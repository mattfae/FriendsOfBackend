class CreateSecondDegrees < ActiveRecord::Migration[5.2]
  def change
    create_table :second_degrees do |t|
      t.string :target_username
      t.string :subject_username
      t.json :target_follows
      t.json :subject_followers
      t.json :mutuals

      t.timestamps
    end
  end
end
