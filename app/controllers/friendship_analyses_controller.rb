class FriendshipAnalysesController < ApplicationController

    def create
        analysis = FriendshipAnalysis.create(analysis_params)
        render json: analysis
    end

    def show
        analysis = FriendshipAnalysis.find(params[:id])
        multi = analysis.collect_return_friends
        render json: multi
    end

    private

    def analysis_params
        params.require(:friendship_analysis).permit(:twitter_account_id, :friends_list, :friends_of)
    end

end
