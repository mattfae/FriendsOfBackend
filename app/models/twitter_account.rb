class TwitterAccount < ApplicationRecord

    has_many :friendship_analyses


    def get_user_by_id(user_id)
        single_user = $client.user(user_id)
    end

    def get_friend_ids_by_user(user_id)
        cursor_object = $client.friend_ids(user_id)
        friends = cursor_object.attrs[:ids]
    end

    def get_follower_ids_by_user(user_id)
        followers = $client.follower_ids(user_id)
    end


    def get_friends_of(friends)
        friends_lim = friends.last(13)
        friends_of = []
        #TODO: change number of requests back to N.
        friends_lim.each do |friend_id|
            friends_of_friend = get_friend_ids_by_user(friend_id)
            friends_of_friend.each do |friend_of_id|
                friend_pair = {"#{friend_of_id}": friend_id}
                friends_of.push(friend_pair)
            end
        end
        reduce_tally_hash(friends_of)
    end


    def reduce_tally_hash(hash_array)
        hash_array.reduce({}) {|h,pairs|
        pairs.each { |k,v|
        (h[k] ||= []) << v
        } ;h
        }
    end


    def generate_friends_of
        $client || create_client
        friends = get_friend_ids_by_user(self.username)
        friends_of_result = get_friends_of(friends)
        friends.to_json
        friends_of_result.to_json
        FriendshipAnalysis.create(twitter_account_id: self.id, username: self.username, friends_list:friends, friends_of: friends_of_result)
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
