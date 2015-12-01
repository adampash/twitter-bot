class AddTimestampsToTweets < ActiveRecord::Migration
  def change
    change_table :tweets, force: true do |t|
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
