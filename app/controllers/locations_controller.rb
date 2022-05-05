# frozen_string_literal: true

class LocationsController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  def list
    @user_id = 0
    if current_user
      @user_id = current_user.id
    else
      render 'no_user', status: :ok, formats: [:json]
      return
    end
    @locations = Location.all.where(user_id: @user_id)
    @location_list = []
    @locations.each do |location|
      @location_list << {
        latlng: [location.lat, location.long]
      }
    end
    render 'list_locations', status: :ok, formats: [:json]
  end

  def list_other
    @user_id = 0
    if current_user
      @user_id = current_user.id
    else
      render 'no_user', status: :ok, formats: [:json]
      return
    end
    @locations = Location.all.where(user_id: @user_id)
    @location_list = []
    @locations.each do |location|
      @location_list << {
        latlng: [location.lat, location.long]
      }
    end
    @other_user_mail = ''
    @other_location_list = []
    @other_user_nickname = ''
    if params[:email]
      @other_user_mail = params[:email]
      @other_user = User.where(email: params[:email]).first
      @other_user_nickname = @other_user.nickname
      if @other_user

        @other_user_id = @other_user.id

        @other_locations = Location.all.where(user_id: @other_user_id)

        @other_locations.each do |location|
          @other_location_list << {
            latlng: [location.lat, location.long]
          }
        end
      end
    end
    render 'list_other_locations', status: :ok, formats: [:json]
  end

  def location_params
    # params.require(:location).permit(:name, :lat, :long, :user_id)
    params.permit(:name, :lat, :long, :user_id)
  end

  def new
    @user_id = current_user.id if current_user
    @location = Location.new
  end

  def create
    if current_user
      if location_params['name'] && location_params['lat'] && location_params['long'] && location_params['user_id']
        @location = Location.create(location_params)
        @message = ''
        @message = if @location.save
                     'Ubicación creeada exitosamente!'
                   else
                     'Hubo un error. Intenta nuevamente.'
                   end
      else
        @message = 'Faltan parametros'
      end
    else
      @message = 'Debes Iniciar sesión'
    end
    render 'create_location', status: :ok, formats: [:json]
  end

  def destroy
    @message = ''
    if current_user
      if params[:id]
        @location = Location.find(params[:id])
        if @location
          @location.destroy
          @message = 'Ubicacion eliminada exitosamente'
        else
          @message = 'No hay ubicacion con ese id'
        end
      else
        @message = 'No hay id'
      end
    else
      @message = 'Debes Iniciar sesión'
    end
    render 'delete_location', status: :ok, formats: [:json]
  end

  def all_users
    @users = User.where.not(confirmed_at: nil)
    render 'all_users', status: :ok, formats: [:json]
  end
end
