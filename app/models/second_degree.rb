class SecondDegree < ApplicationRecord

    def get_target_follows
        cursor_object = client.friend_ids(self.target_username)
        self.target_follows = cursor_object.attrs[:ids]
        self.target_follows
    end

    def get_subject_followers
        cursor_object = client.follower_ids(self.subject_username)
        self.subject_followers = cursor_object.attrs[:ids]
        self.subject_followers
    end

    def get_mutuals
        mut = self.target_follows & self.subject_followers
        self.mutuals = mut
        self.mutuals
    end

    def collect_data
        self.get_target_follows
        self.get_subject_followers
        self.get_mutuals
    end

    def get_user(user_id)
        single_user = client.user(user_id)
    end

    def parse_mutuals
        users = self.mutuals.map do |user|
                    one_user = get_user(user)
                end
    end

end
