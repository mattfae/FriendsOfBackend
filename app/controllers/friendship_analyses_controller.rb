class FriendshipAnalysesController < ApplicationController

    def create
        analysis = FriendshipAnalysis.create(analysis_params)
    end

    private

    def analysis_params
        params.require(:friendship_analysis).permit(:twitter_account_id, :friends_list, :friends_of)
    end

end
