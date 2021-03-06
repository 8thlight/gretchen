class Vacation < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :google_id

  validates :start_date,  :presence => true
  validates :end_date,    :presence => true

  belongs_to :user
end
