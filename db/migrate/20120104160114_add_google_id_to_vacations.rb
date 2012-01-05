class AddGoogleIdToVacations < ActiveRecord::Migration
  def change
    add_column :vacations, :google_id, :string
  end
end
