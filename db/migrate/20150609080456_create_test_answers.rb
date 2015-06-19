class CreateTestAnswers < ActiveRecord::Migration
  def change
    create_table :test_answers do |t|
      t.string :status
      t.integer :score
      t.belongs_to :user, index: true
      t.belongs_to :test, index: true
      t.timestamps
    end
  end
end
