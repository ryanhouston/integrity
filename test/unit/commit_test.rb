require "helper"

class CommitTest < IntegrityTest
  setup do
    @commit = Commit.gen(:integrity)
  end

  it "should return a github url to view the commit" do
    assert_equal 'http://github.com/foca/integrity/commit/705f396fd6ee2fa4b98be3d81f6b452e3f95b3e7',
      @commit.github_url.to_s
  end
end
