class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  protect_from_forgery with :exception

  private
  
  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = session['access_token']
      config.access_token_secret = session['access_token_secret']
    end
  end

end
