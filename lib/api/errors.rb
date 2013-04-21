module RushourAPI

  class NotFound < StandardError
  end

  class InvalidParameters < StandardError
    def initialize(raw_message)
      @raw_message = raw_message
      super
    end
    def message
      @raw_message
    end
  end

  class HttpError < StandardError
    attr_accessor :response
    def initialize(message, response)
      self.response = response
      super(message)
    end
  end

end
