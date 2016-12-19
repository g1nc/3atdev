class CreateSalaries < ActiveRecord::Migration[5.0]
  def change
    create_table :salaries do |t|
      t.date :starts_at
      t.date :ends_at
      t.references :user
      t.timestamps
    end
  end
end
