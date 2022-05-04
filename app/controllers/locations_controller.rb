class LocationsController < ApplicationController
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
    def list
        @user_id = 0
        if current_user
            @user_id = current_user.id
        end
        @locations = Location.all.where(user_id: @user_id )
        @location_list = Array.new
        @locations.each do |location|
            @location_list << {
                :latlng => [location.lat, location.long]
            }
        end
        render 'list_locations', status: :ok, formats: [:json]
    end
    def list_other
        @user_id = 0
        if current_user
            @user_id = current_user.id
        end
        @locations = Location.all.where(user_id: @user_id )
        @location_list = Array.new
        @locations.each do |location|
            @location_list << {
                :latlng => [location.lat, location.long]
            }
        end
        @other_user_mail = ""
        @other_location_list = Array.new
        if params[:email]
            @other_user_mail = params[:email]
            @other_user = User.where(email: params[:email]).first
            if @other_user
                
                @other_user_id = @other_user.id
        
                @other_locations = Location.all.where(user_id: @other_user_id )
                
                @other_locations.each do |location|
                    @other_location_list << {
                        :latlng => [location.lat, location.long]
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
        if current_user
            @user_id = current_user.id
        end
        @location = Location.new
    end

    def create
        if current_user
            if (location_params['name'] && location_params['lat'] && location_params['long'] && location_params['user_id'])
                @location = Location.create(location_params)
                @message = ""
                if @location.save
                    @message = 'Ubicación creeada exitosamente!'
                    render 'create_location', status: :ok, formats: [:json]
                else
                    @message = 'Hubo un error. Intenta nuevamente.'
                    render 'create_location', status: :ok, formats: [:json]
                end
            else
                @message = 'Faltan parametros'
                render 'create_location', status: :ok, formats: [:json]
            end
        else
            @message = 'Debes Iniciar sesión'
            render 'create_location', status: :ok, formats: [:json]
        end

    end

    def destroy
        @message = ''
        if params[:id]
            @location = Location.find(params[:id])
            @location.destroy
            @message = 'Ubicacion eliminada exitosamente'
        else    
            @message = 'No hay id'
        end
        render 'delete_location', status: :ok, formats: [:json]
        
      end
end
