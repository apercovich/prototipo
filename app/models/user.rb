class User < ActiveRecord::Base
  has_many :routes
  has_many :tasks, dependent: :destroy
  
  belongs_to :role, class_name: "UserRole"
  belongs_to :state, class_name: "UserState"
  
  
  #Controles para el registro (http://ruby.railstutorial.org/chapters/modeling-users)
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  
end
