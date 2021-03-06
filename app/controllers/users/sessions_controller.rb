# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]

    # prepend_before_action :require_no_authentication, only: [:new, :create]
    # prepend_before_action :allow_params_authentication!, only: :create
    # prepend_before_action :verify_signed_out_user, only: :destroy
    # prepend_before_action(only: [:create, :destroy]) { request.env["devise.skip_timeout"] = true }
    skip_before_action :verify_authenticity_token
    # GET /resource/sign_in
    def new
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      yield resource if block_given?
      respond_with(resource, serialize_options(resource))
    end

    # POST /resource/sign_in
    def create
      create_new
    end

    def create_new
      if current_user
        @message = 'You are already signed in'
        render 'sign_in', status: :ok, formats: [:json]
        return
      end
      user = User.find_by(email: params['email'].downcase)
      if user
        if user.confirmed_at
          if user.valid_password?(params['password'])
            current_user = user
            sign_in(user)
            @message = 'Succesfully signed in!!'
          else
            @message = 'Usuario o contraseña incorrecto'
          end
        else
          @message = 'No has verificado tu cuenta'
        end
      else
        @message = 'Usuario no registrado'
      end
      render 'sign_in', status: :ok, formats: [:json]
    end

    # DELETE /resource/sign_out
    def destroy
      Rails.logger.debug("LAMANDOOO\n\n")
      if current_user
        signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
        @message = ''
        @message = if signed_out
                     'Signed Out'
                   else
                     'cannot sign out'
                   end
      else
        @message = 'No current user'
      end
      render 'sign_in', status: :ok, formats: [:json]
    end

    protected

    def sign_in_params
      devise_parameter_sanitizer.sanitize(:sign_in)
    end

    def serialize_options(resource)
      methods = resource_class.authentication_keys.dup
      methods = methods.keys if methods.is_a?(Hash)
      methods << :password if resource.respond_to?(:password)
      { methods: methods, only: [:password] }
    end

    def auth_options
      { scope: resource_name, recall: "#{controller_path}#new" }
    end

    def translation_scope
      'devise.sessions'
    end

    private

    # Check if there is no signed in user before doing the sign out.
    #
    # If there is no signed in user, it will set the flash message and redirect
    # to the after_sign_out path.
    def verify_signed_out_user
      if all_signed_out?
        @message = 'Already signed out'
        render 'sign_in', status: :ok, formats: [:json]
      end
    end

    def require_no_authentication
      Rails.logger.debug("hi baby\n\n")
    end

    def all_signed_out?
      users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }

      users.all?(&:blank?)
    end

    def respond_to_on_destroy
      # We actually need to hardcode this as Rails default responder doesn't
      # support returning empty response on GET request
      respond_to do |format|
        format.all { head :no_content }
        format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
      end
    end
  end
end
