require "helper"

class RepositoryTest < IntegrityTest
  setup do
    @repo = Repository.new('git://notgithub.com/integrity/integrity.git', 'master')
  end

  it "has a uri" do
    assert_equal 'git://notgithub.com/integrity/integrity.git', @repo.uri
  end

  it "has a branch" do
    assert_equal 'master', @repo.branch
  end
end
