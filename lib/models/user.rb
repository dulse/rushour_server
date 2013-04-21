module Rushour
  module Models
    class User < ActiveRecord::Base
      has_many :places, dependent: :destroy
      has_many :commute_templates, dependent: :destroy
      has_many :commutes, dependent: :destroy
    end
  end
end
