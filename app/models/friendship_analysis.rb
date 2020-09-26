class FriendshipAnalysis < ApplicationRecord

    belongs_to :twitter_account


    def multi_friends_filter(friends_of)
        friends_of.select { |k, v| v.length > 2 }
    end

    def collect_return_friends
        filtered = self.friends_of.select { |k, v| v.length > 2 }
        sorted_array = filtered.sort_by { |k, v| -v.length }
        some_friends_of = sorted_array.first(20)
    end

    def get_users
        create_client
        friendships_array = self.collect_return_friends
        friendships_array.map do |friends_of_rel|
            new_rel = []
            friend_of = $client.user(friends_of_rel[0].to_i)
            new_rel[0] = friend_of.screen_name
            new_friends = friends_of_rel[1].map do |friend|
                friend_obj = $client.user(friend)
                new_friend = friend_obj.screen_name
            end
            new_rel.push(new_friends)
        end
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

