require 'grape'

module API
  class Rushour < Grape::API

    prefix 'api'
    version 'v1'
    format :json

    helpers do
      def current_user
        @current_user ||= env['RUSHOUR_CURRENT_USER']
      end
    end

    rescue_from :all do |e|
      Rack::Response.new({error: e.message }.to_json, 500, { 'Content-type' => 'application/json' }).finish
    end

    rescue_from API::NotFound do |e|
      Rack::Response.new({error: e.message }.to_json, 404, { 'Content-type' => 'application/json' }).finish
    end

    rescue_from API::InvalidParameters, Grape::Exceptions::Validation do |e|
      Rack::Response.new({error: e.message }.to_json, 400, { 'Content-type' => 'application/json' }).finish
    end

  end
end
