class AdminController < ApplicationController
  include ActionView::RecordIdentifier
  PER_PAGE = 10

  def list_invitation_codes
    load_invitation_codes
  end

  def create_invitation_codes
    status = current_status_param
    count = params.fetch(:count, 1).to_i

    if count < 1
      redirect_to admin_invitation_codes_path(status: status), alert: "Count must be at least 1."
      return
    end

    created = 0
    errors = []

    count.times do
      code = InvitationCode.new(token: InvitationCode.generate_token)
      if code.save
        created += 1
      else
        errors.concat(code.errors.full_messages)
      end
    end

    if errors.empty?
      message = "#{created} invitation code#{'s' unless created == 1} created."
      redirect_to admin_invitation_codes_path(status: status), notice: message
    else
      error_message = "Created #{created} code#{'s' unless created == 1}. Errors: #{errors.uniq.join('; ')}"
      redirect_to admin_invitation_codes_path(status: status), alert: error_message
    end
  end

  def toggle_invitation_code_sent
    status = current_status_param
    @invitation_code = InvitationCode.find(params[:id])
    @invitation_code.toggle_sent!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          dom_id(@invitation_code),
          partial: "admin/invitation_code_row",
          locals: { code: @invitation_code, current_page: current_page_param, current_status: status }
        )
      end

      format.html do
        redirect_to admin_invitation_codes_path(page: current_page_param, status: status),
                    notice: "Invitation code updated."
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.turbo_stream do
        flash.now[:alert] = e.record.errors.full_messages.to_sentence
        load_invitation_codes
        render :list_invitation_codes, status: :unprocessable_entity
      end

      format.html do
        redirect_to admin_invitation_codes_path(page: current_page_param, status: status),
                    alert: e.record.errors.full_messages.to_sentence
      end
    end
  end

  def soft_delete_invitation_code
    status = current_status_param
    @invitation_code = InvitationCode.find(params[:id])
    @invitation_code.soft_delete!

    respond_to do |format|
      format.turbo_stream do
        if status == "active"
          render turbo_stream: turbo_stream.remove(dom_id(@invitation_code))
        else
          render turbo_stream: turbo_stream.replace(
            dom_id(@invitation_code),
            partial: "admin/invitation_code_row",
            locals: { code: @invitation_code, current_page: current_page_param, current_status: status }
          )
        end
      end

      format.html do
        redirect_to admin_invitation_codes_path(page: current_page_param, status: status),
                    notice: "Invitation code deleted."
      end
    end
  end

  private

  def current_page_param
    [ params.fetch(:page, 1).to_i, 1 ].max
  end

  def current_status_param
    status = params[:status].presence_in(%w[active deleted all]) || "active"
    @status = status
  end

  def load_invitation_codes
    @page = current_page_param
    @per_page = PER_PAGE
    status = current_status_param

    scoped_codes =
      case status
      when "deleted" then InvitationCode.deleted
      when "all" then InvitationCode.all
      else InvitationCode.active
      end

    @total_count = scoped_codes.count
    @total_pages = [ (@total_count.to_f / @per_page).ceil, 1 ].max
    offset = (@page - 1) * @per_page

    @invitation_codes = scoped_codes.order(created_at: :desc)
                                    .offset(offset)
                                    .limit(@per_page)
  end
end
