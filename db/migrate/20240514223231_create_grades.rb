class CreateGrades < ActiveRecord::Migration[7.0]
  def up
    create_table :grades do |t|
      t.belongs_to :evaluation, null: false, foreign_key: true
      t.belongs_to :criterion, null: false, foreign_key: true
      t.float      :score
      t.timestamps
    end
  end

  def down
    drop_table :grades
  end
end
