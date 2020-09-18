class TwitterAccountsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def index
        accounts = TwitterAccount.all
        render json: accounts
    end

    def create
        account = TwitterAccount.create(username: params[:username])
        render json: account
    end

    def show
    end

    private

    def acct_params
        params.require(:twitter_account).permit(:username)
    end

end
