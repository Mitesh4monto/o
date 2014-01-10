class CreateCommitmentMarks < ActiveRecord::Migration
  def change
    create_table :commitment_marks do |t|
      t.integer :user_id
      t.date :done_date
      t.integer :cmable_id
      t.string :cmable_type

      t.timestamps
    end
  end
end
