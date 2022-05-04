# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  skip_before_action :verify_authenticity_token
  respond_to :json


  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    @message = ''
    user = User.find_by_email(params['email'].downcase)
    if user
      @message = 'Ya hay un usuario registrado con este mail'
    elsif params['password'] && params['password_confirmation']
      if params['password'] == params['password_confirmation']
        user = User.new
        user.email = params['email']
        user.password = params['password']
        user.save
        @message = 'Registrado exitosamente'
      else
        @message = 'Password and confirmation must be the same'
      end
    else
      @message = 'faltan parametros'
    end
    
    render 'sign_up', status: :ok, formats: [:json]
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
