class SecondDegreesController < ApplicationController

    skip_before_action :verify_authenticity_token

    def create
        new_req = SecondDegree.create(
            target_username: degree_params[:target_username],
            subject_username: degree_params[:subject_username],
            target_follows: nil,
            subject_followers: nil,
            mutuals: nil)
        new_req.get_target_follows
        new_req.get_subject_followers
        render json: new_req
    end


    private

    def degree_params
        params.require(:second_degree).permit(:target_username, :subject_username)
    end

end
