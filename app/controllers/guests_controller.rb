class GuestsController < ApplicationController
  def create
  end

  def list
    @guests = Guest.all
  end

  def detail
  end

  def delete
  end
end
