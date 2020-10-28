class SecondDegreesController < ApplicationController

    skip_before_action :verify_authenticity_token

    def create
        new_req = SecondDegree.create(
            target_username: degree_params[:target_username],
            subject_username: degree_params[:subject_username],
            target_follows: nil,
            subject_followers: nil,
            mutuals: nil)
        new_req.collect_data
        mutuals = new_req.parse_mutuals
        render json: mutuals
    end


    private

    def degree_params
        params.require(:second_degree).permit(:target_username, :subject_username)
    end

end
