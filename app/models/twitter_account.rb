class TwitterAccount < ApplicationRecord

    has_many :friendship_analyses

    def create_client
        $client = Twitter::REST::Client.new do |config|
            config.consumer_key        = "7KFbMOq6pVpJjNOJjq0E4tswz"
            config.consumer_secret     = "ubXurwWBLdvbzi9oKPcvJl8wIGSIyDU5GDGeiY4ACITPG01X5h"
            config.access_token        = "792601942937579520-DiLZg2eG6wgQPkBTWCz3vt3bUrJQhKt"
            config.access_token_secret = "1ZW4ch1Pr6DjO71QX8YHXuXDK1yg9H5pGmhYA4K5AQkU3"
        end
    end

    
    def get_user_by_id(user_id)
        single_user = $client.user(self.username)
    end

    def get_friend_ids_by_user(user_id)
        friends = $client.friend_ids(self.username)
    end

    def get_follower_ids_by_user(user_id)
        followers = $client.follower_ids(user_id)
    end
    

    def generate_friends_of
        create_client
        cursor_object = get_friend_ids_by_user(self.username)
        #TODO: change number of requests back to N.
        first_ten_friends = cursor_object.attrs[:ids].last(1)

        friends_of = []
        first_ten_friends.each do |friend_id|
            friend_cursor = get_friend_ids_by_user(friend_id)
            friends_of.push(*friend_cursor.attrs[:ids])
        end
        save_friends_of = friends_of
        friends_of_string = friends_of.to_s
        friends_of_count = Hash[*friends_of.inject(Hash.new(0)) { |h,v| h[v] += 1; h }.sort_by{|k,v| v}.reverse.flatten]
        friends_of_json = JSON.generate(friends_of_count)
        FriendshipAnalysis.create(twitter_account_id: self.id, friends_of:friends_of_string, friends_of: friends_of_count)
    end


end
