class Task < ActiveRecord::Base
  belongs_to :user
  
  #Validaciones
  validates :user, :presence => true
  validates :date, :presence => true
  validates :time_start, :presence => true
  validates :time_end, :presence => true
  validates :description, :presence => true
end
