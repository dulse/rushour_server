module Rushour
  module Models
    class CommuteTemplate < ActiveRecord::Base
      belongs_to :user
      has_one :start_place, foreign_key: 'start_place_id', class_name: 'Rushour::Models::Place'
      has_one :end_place, foreign_key: 'end_place_id', class_name: 'Rushour::Models::Place'
    end
  end
end
