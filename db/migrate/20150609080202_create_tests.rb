class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :name, unique: true
      t.text :description
      t.timestamp :begins_at
      t.timestamp :ends_at
      t.integer :questions_amount

      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
