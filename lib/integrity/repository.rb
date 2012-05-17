module Integrity
  class Repository
    attr_reader :uri, :branch, :account, :name

    def initialize (uri, branch)
      @uri    = uri
      @branch = branch
      find_account_and_name
    end

    def github_uri?
      @uri.to_s.index /^.*github.com\/(.*)\/(.*)?(.git)/
    end

    def github_url
      if github_uri?
        base_url = Addressable::URI.parse('http://github.com')
        base_url.join("#{account}/#{name}/")
      end
    end

    private
    def find_account_and_name
      if matches = /^.*github.com\/(.*)\/(.*)?(.git)/.match(@uri)
        @name     = matches[2]
        @account  = matches[1]
      end
    end

  end
end
