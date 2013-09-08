class Route < ActiveRecord::Base
  belongs_to :user
  
  #Auto-relacion
  belongs_to :previous, class_name: "Route"
  has_one :next, class_name: "Route", foreign_key: "previous_id"
end
