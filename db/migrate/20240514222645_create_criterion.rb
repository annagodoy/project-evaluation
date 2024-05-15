class CreateCriterion < ActiveRecord::Migration[7.0]
  def up
    create_table :criterions do |t|
      t.float :weight
      t.timestamps
    end
  end

  def down
    drop_table :criterions
  end
end
