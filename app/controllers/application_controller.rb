class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :validate_otp_verified
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # to redirect to the OTP verification page if the OTP is not verified
  def validate_otp_verified
    redirect_to otp_confirmed_check_path if user_signed_in? && !current_user.otp_verified
  end

  # overriding to accept phone as parameter for device sign_up
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:phone, :email, :password) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:phone, :email, :password, :current_password)
    end
  end
end
