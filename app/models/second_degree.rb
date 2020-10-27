class SecondDegree < ApplicationRecord

    def get_target_follows
        cursor_object = client.friend_ids(self.target_username)
        self.target_follows = cursor_object.attrs[:ids]
    end

    def get_subject_followers
        cursor_object = client.follower_ids(self.subject_username)
        self.subject_followers = cursor_object.attrs[:ids]
    end

    def get_mutuals
    end

end