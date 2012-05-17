module Integrity
  class Commit
    include DataMapper::Resource

    property :id,           Serial
    property :build_id,     Integer
    property :identifier,   String
    # message should properly be called subject, but with datamapper
    # lacking sensible documentation and having unfixed bugs in the version
    # used by integrity at the time (1.0) trying to get migrations working is
    # excessively painful. Brave souls should feel free to fix this deficiency.
    # See https://github.com/datamapper/dm-migrations/commit/cd9d62ee08b6615a2d1ab2482b24d72232d867a3
    # message is actually subject truncated to 255 characters.
    property :message,      String,   :length => 255
    # complete commit message (both subject and body in git parlance).
    # "message" is a prefix of "full_message".
    property :full_message, Text
    property :author,       Author,   :length => 255
    property :committed_at, DateTime

    timestamps :at

    belongs_to :build

    def github_url
      if build.repo.github_uri?
        base_url = build.repo.github_url
        base_url.join("commit/#{identifier}")
      end
    end

  end
end
