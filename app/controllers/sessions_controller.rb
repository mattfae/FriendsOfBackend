class SessionsController < ApplicationController

    def create
        return_hash = auth_hash
        #credentials = auth_hash['credentials']
        #session[:access_token] = credentials['token']
        #session[:access_token_secret] = credentials['secret']
        #redirect_to show_path, notice: 'Signed in'
        render json: return_hash
    end

    def show
      if session['access_token'] && session['access_token_secret']
        @user = client.user(include_entities: true)
      else
        redirect_to failure_path
      end
    end

    def error
      flash[:error] = 'Sign in with Twitter failed'
      redirect_to root_path
    end

    def destroy
      reset_session
      redirect_to root_path, notice: 'Signed out'
    end

    protected

    def auth_hash
      request.env['omniauth.auth']
    end

end
