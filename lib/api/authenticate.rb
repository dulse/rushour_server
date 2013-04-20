module API
  class Authenticate
    def initialize(app)
      @app = app
    end

    def call(env)
      api_token = env['HTTP_API_TOKEN']
      return [401, {"Content-Type"=>"text/plain"}, ["Unauthorized"]] unless api_token && env['RUSHOUR_CURRENT_USER'] = Rushour::Models::User.find_by_api_token(api_token)
      @app.call(env)
    end

  end
end
