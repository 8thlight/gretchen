class User < ActiveRecord::Base

  attr_accessible :name, :email, :vacationdays, :uid, :provider, :token

  has_many :vacations, :dependent => :destroy

  email_regex = /\A[\w+\-.]+@(8thlight.com)/i


  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }

  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

  def self.create_with_omniauth(auth)
    user = User.new(:provider => auth["provider"],
      :uid => auth["uid"],
      :name => auth["info"]["name"],
      :email => auth["info"]["email"])
  end
end
