class TwitterAccountsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def create
        account = TwitterAccount.create(acct_params)
        analysis = account.generate_friends_of
        render json: analysis
    end

    private

    def acct_params
        params.require(:twitter_account).permit(:username)
    end

end
