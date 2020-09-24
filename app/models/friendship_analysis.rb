class FriendshipAnalysis < ApplicationRecord

    belongs_to :twitter_account


    def multi_friends_filter(friends_of)
        friends_of.select { |k, v| v.length > 2 }
    end
    
    def sort_val_length(friends_of_hash)
        sorted_array = friends_of_hash.sort_by { |k, v| -v.length }
        some_friends_of = sorted_array.first(20)
    end

    def collect_return_friends
        sort_val_length(multi_friends_filter(self.friends_of))
    end


    private

    def create_client
        $client = Twitter::REST::Client.new do |config|
            config.consumer_key        = "7KFbMOq6pVpJjNOJjq0E4tswz"
            config.consumer_secret     = "ubXurwWBLdvbzi9oKPcvJl8wIGSIyDU5GDGeiY4ACITPG01X5h"
            config.access_token        = "792601942937579520-DiLZg2eG6wgQPkBTWCz3vt3bUrJQhKt"
            config.access_token_secret = "1ZW4ch1Pr6DjO71QX8YHXuXDK1yg9H5pGmhYA4K5AQkU3"
        end
    end

end
