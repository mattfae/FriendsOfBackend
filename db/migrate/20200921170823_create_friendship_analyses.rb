class CreateFriendshipAnalyses < ActiveRecord::Migration[5.2]
  def change
    create_table :friendship_analyses do |t|
      t.integer :twitter_account_id
      t.text :friends_list
      t.json :friends_of

      t.timestamps
    end
  end
end
