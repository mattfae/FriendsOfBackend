class TwitterAccount < ApplicationRecord


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
    

    # get a collection of the input user's friends

    # iterate over the list of friends
    #    for each, get their friends
    #    add each account to a list
    #    create a descending list of accounts by number of times they appear on the whole list.

    # get each of those usernames and list them by number of appearances

    def generate_friends_of
        create_client
        cursor_object = get_friend_ids_by_user(self.username)
        first_ten_friends = cursor_object.attrs[:ids].last(10)
        friends_of = []
        first_ten_friends.each do |friend_id|
            friend_cursor = get_friend_ids_by_user(friend_id)
            friends_of.push(*friend_cursor.attrs[:ids])
        end
        friends_of_count = friends_of.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
    end

end
