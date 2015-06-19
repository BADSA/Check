class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :title
      t.string :type
      t.string :choice1
      t.string :choice2
      t.string :choice3
      t.string :choice4
      t.string :right_answer
      t.belongs_to :test, index: true
      t.timestamps
    end
  end
end
