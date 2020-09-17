class TwitterAccount < ApplicationRecord

    
    def create_client
        client = Twitter::REST::Client.new do |config|
            config.consumer_key        = "7KFbMOq6pVpJjNOJjq0E4tswz"
            config.consumer_secret     = "ubXurwWBLdvbzi9oKPcvJl8wIGSIyDU5GDGeiY4ACITPG01X5h"
            config.access_token        = "792601942937579520-DiLZg2eG6wgQPkBTWCz3vt3bUrJQhKt"
            config.access_token_secret = "1ZW4ch1Pr6DjO71QX8YHXuXDK1yg9H5pGmhYA4K5AQkU3"
        end
    end

    def get_user_by_id(user_id)
        client = create_client
        single_user = client.user(user_id)
    end

    def get_friend_ids_by_user(user_id)
        client = create_client
        friends = client.friend_ids(user_id)
    end

    def get_follower_ids_by_user(user_id)
        client = create_client
        followers = client.follower_ids(user_id)
    end

    def generate_friends_of
    end


end
