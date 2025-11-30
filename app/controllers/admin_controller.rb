class AdminController < ApplicationController
  include ActionView::RecordIdentifier
  PER_PAGE = 20

  def list_invitation_codes
    load_invitation_codes
  end

  def create_invitation_codes
    count = params.fetch(:count, 1).to_i

    if count < 1
      redirect_to admin_invitation_codes_path, alert: "Count must be at least 1."
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
      redirect_to admin_invitation_codes_path, notice: message
    else
      error_message = "Created #{created} code#{'s' unless created == 1}. Errors: #{errors.uniq.join('; ')}"
      redirect_to admin_invitation_codes_path, alert: error_message
    end
  end

  def toggle_invitation_code_sent
    @invitation_code = InvitationCode.find(params[:id])
    @invitation_code.toggle_sent!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          dom_id(@invitation_code),
          partial: "admin/invitation_code_row",
          locals: { code: @invitation_code, current_page: current_page_param }
        )
      end

      format.html do
        redirect_to admin_invitation_codes_path(page: current_page_param),
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
        redirect_to admin_invitation_codes_path(page: current_page_param),
                    alert: e.record.errors.full_messages.to_sentence
      end
    end
  end

  private

  def current_page_param
    [ params.fetch(:page, 1).to_i, 1 ].max
  end

  def load_invitation_codes
    @page = current_page_param
    @per_page = PER_PAGE
    @total_count = InvitationCode.count
    @total_pages = [ (@total_count.to_f / @per_page).ceil, 1 ].max
    offset = (@page - 1) * @per_page

    @invitation_codes = InvitationCode.order(created_at: :desc)
                                      .offset(offset)
                                      .limit(@per_page)
  end
end
