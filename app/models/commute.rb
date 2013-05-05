class Commute < ActiveRecord::Base
  has_many :trips
  has_many :commute_instances
end