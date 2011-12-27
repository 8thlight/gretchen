class CreateVacations < ActiveRecord::Migration
  def change
    create_table :vacations do |t|
      t.date :start_date
      t.date :end_date
      t.integer :user_id

      t.timestamps
    end
  end
end
