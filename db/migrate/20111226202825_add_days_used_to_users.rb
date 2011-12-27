class AddDaysUsedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :days_used, :integer, :default => 0
  end
end
