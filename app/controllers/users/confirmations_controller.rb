# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    @user = User.where(confirmation_token: params['confirmation_token']).first
    if @user
      @user.confirmed_at = Time.now.to_date
      @user.save
      @message = 'Cuenta verificada exitosamente'
    else
      @message = 'error'
    end
    render 'confirmation', status: :ok, formats: [:json]
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
