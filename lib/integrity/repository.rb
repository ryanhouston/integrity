module Integrity
  class Repository
    attr_reader :uri, :branch

    def initialize (uri, branch)
      @uri    = uri
      @branch = branch
    end
  end
end
