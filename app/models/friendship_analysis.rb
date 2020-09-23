class FriendshipAnalysis < ApplicationRecord

    belongs_to :twitter_account


    # friends_of_string = friends_of.to_s
    # friends_of_count = Hash[*friends_of.inject(Hash.new(0)) { |h,v| h[v] += 1; h }.sort_by{|k,v| v}.reverse.flatten]
    # friends_of_json = JSON.generate(friends_of_count)
    
end
