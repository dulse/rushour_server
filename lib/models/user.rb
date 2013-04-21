module Rushour
  module Models
    class User < ActiveRecord::Base
      has_many :places, dependent: :destroy
      has_many :commute_templates, dependent: :destroy
      has_many :commutes, dependent: :destroy

      def push_notification(at, message = 'Time to wake the hell up!')
        Urbanairship.push(:schedule_for => at,
                          :device_tokens => [self.device_token],
                          :aps => {:alert => message, :badge => 1})
      end
    end
  end
end
