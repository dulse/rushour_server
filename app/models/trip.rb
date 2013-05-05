class Trip < ActiveRecord::Base
  belongs_to :commute
  has_one :start_location, :class_name => "Location", :foreign_key => "start_location_id"
  has_one :end_location, :class_name => "Location", :foreign_key => "end_location_id"
end