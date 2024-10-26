class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.string :image
      t.text :about
      t.string :spot
      t.string :spot2
      t.string :spot3
      t.string :title
      t.timestamps
    end
  end
end
