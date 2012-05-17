require "helper"

class RepositoryTest < IntegrityTest
  setup do
    @repo = Repository.new('git://github.com/joebloe/integrity.git', 'hack-the-planet')
  end

  it "should allow a github uri" do
    assert_equal 'git://github.com/joebloe/integrity.git', @repo.uri
  end

  it "has a branch" do
    assert_equal 'hack-the-planet', @repo.branch
  end

  it "finds a github account name" do
    assert_equal 'joebloe', @repo.account
  end

  it "finds a github repo name" do
    assert_equal 'integrity', @repo.name
  end

  it "has a github url" do
    assert_equal 'http://github.com/joebloe/integrity/', @repo.github_url.to_s
  end

  it "should allow a non-github uri" do
    repo = Repository.new('../../tmp/my_test_project/', 'master')
    assert_equal '../../tmp/my_test_project/', repo.uri
  end

end
