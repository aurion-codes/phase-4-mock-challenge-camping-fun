class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found


    def index
        activities= Activity.all
        render json: activities
    end

    def destroy
        activity = Activity.find_by(id: params[:id])
        if activity
            activity.destroy
            head :no_content
        else
            render_not_found
        end
    end

    private

    def render_not_found
        render json: { error: "Activity not found" }, status: :not_found 
    end
end

