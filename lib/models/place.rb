module Rushour
  module Models
    class Place < ActiveRecord::Base
      belongs_to :user
    end
  end
end
