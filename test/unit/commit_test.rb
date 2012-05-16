require "helper"

class CommitTest < IntegrityTest
  setup do
    @project = Project.gen(:github_url)
    @project.builds.create(
      :commit => Commit.gen_attrs.update(:identifier => Digest::SHA1.hexdigest('hack-the-planet')))
  end

  it "should return a github url to view the commit" do
    assert_equal 'http://github.com/foca/integrity/commit/705f396fd6ee2fa4b98be3d81f6b452e3f95b3e7',
      @project.builds.first.commit.github_url.to_s
  end
end
