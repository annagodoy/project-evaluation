class CreateEvaluations < ActiveRecord::Migration[7.0]
  def up
    create_table :evaluations do |t|
      t.belongs_to  :project, null: false, foreign_key: true
      t.float       :weighted_score
      t.string      :title
      t.timestamps
    end
  end

  def down
    drop_table :evaluations
  end
end
