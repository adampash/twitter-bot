class Schema < ActiveRecord::Migration
  def change
    create_table :tweets, force: true do |t|
      t.text :text
      t.boolean :tweeted, default: false
    end
  end
end
