require 'grape'

module RushourAPI
  class API < Grape::API

    prefix 'api'
    version 'v1'
    format :json

    rescue_from :all do |e|
      Rack::Response.new({error: e.message }.to_json, 500, { 'Content-type' => 'application/json' }).finish
    end

    rescue_from RushourAPI::NotFound do |e|
      Rack::Response.new({error: e.message }.to_json, 404, { 'Content-type' => 'application/json' }).finish
    end

    rescue_from RushourAPI::InvalidParameters, Grape::Exceptions::Validation do |e|
      Rack::Response.new({error: e.message }.to_json, 400, { 'Content-type' => 'application/json' }).finish
    end

    resource 'user' do
      get '/:id' do
        Rushour::Models::User.find(params[:id])
      end

      get '/:id/places' do
        Rushour::Models::Place.where(user_id: params[:id])
      end

      post '/' do
        if u = Rushour::Models::User.where(device_token: params[:device_token]).first
          u.update_attributes(params)
        else
          Rushour::Models::User.create(params)
        end
      end
    end

  end
end
