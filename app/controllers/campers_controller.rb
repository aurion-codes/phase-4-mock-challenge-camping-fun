class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def index
        campers = Camper.all 
        render json: campers
    end

    def show
        camper = Camper.find_by(id: params[:id])
       if camper
        render json: camper, serializer: CamperActivitySerializer
       else 
        render_not_found
       end
    end

    def create
        camper = Camper.create!(camper_params)
        if camper.valid?
            render json: camper, status: :created
        else
            record_invalid
        end
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def record_invalid
        render json: {error: "Validation errors"}, status: :unprocessable_entity
    end
    
    def render_not_found
        render json: { error: "Camper not found"}, status: :not_found
    end

end

    