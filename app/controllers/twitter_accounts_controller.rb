class TwitterAccountsController < ApplicationController

    def new
        twitter_account = TwitterAccount.new
    end

    def create
    end

    def show
    end

    private

    def acct_params
        params.require(:twitter_account).permit(:username)
    end

end
