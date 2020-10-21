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
            config.consumer_key        = ENV['CONSUMER_KEY']
            config.consumer_secret     = ENV['CONSUMER_SECRET']
            config.access_token        = ENV['ACCESS_TOKEN']
            config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
        end
    end

end
