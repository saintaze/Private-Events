class ApplicationController < ActionController::Base
  # after_action :return_errors, only: [:page_not_found, :server_error]
  
  include SessionsHelper

  # when authenticity error is thrown which is when post request is made without or with invalid CSRF token catch it with this action
  rescue_from ActionController::InvalidAuthenticityToken, with: :rescue_422

  def rescue_422
    flash[:danger] = "Invalid submission"
    redirect_to root_url
  end


  def page_not_found
      @status = 404
      @layout = "application"
      @template = "not_found_error"
      render 'errors/not_found_error'

  end

  def server_error
      @status = 500
      @layout = "error"
      @template = "internal_server_error"
  end

  private

  def return_errors
      respond_to do |format|
            format.html { render template: 'errors/' + @template, layout: 'layouts/' + @layout, status: @status }
            format.all  { render nothing: true, status: @status }
      end
  end


  
end
