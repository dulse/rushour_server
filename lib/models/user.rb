module Rushour
  module Models
    class User < ActiveRecord::Base
      has_many :places
      has_many :commute_templates
      has_many :commutes
    end
  end
end
