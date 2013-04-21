module Rushour
  module Models
    class Commute < ActiveRecord::Base
      belongs_to :user
      belongs_to :commute_template
    end
  end
end
