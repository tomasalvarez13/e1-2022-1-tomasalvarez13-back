class LocationsController < ApplicationController
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


    end

    def location_params
        params.require(:location).permit(:name, :lat, :long, :user_id)
    end

    def new
        if current_user
            @user_id = current_user.id
        end
        @location = Location.new
    end

    def create
        @location = Location.create(location_params)
        if @location.save
          redirect_to list_locations_path, notice: 'Ubicación creeada exitosamente!'
        else
          redirect_to new_location_path, notice: 'Hubo un error. Intenta nuevamente.'
        end
    end

    def destroy
        @location = Location.find(params[:id])
        @location.destroy
        redirect_to list_locations_path, notice: 'Ubicaion eliminada exitosamente'
      end
end
