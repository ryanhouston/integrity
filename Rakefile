$LOAD_PATH.unshift(File.expand_path(File.dirname(".")))
require "rake/testtask"
require "rake/clean"
require 'rspec/core/rake_task'

desc "Default: run all tests"
task :default => :test

desc "Run tests"
task :test => %w[test:unit test:acceptance]
namespace :test do
  desc "Run unit tests"
  Rake::TestTask.new(:unit) do |t|
    t.libs << "test"
    t.test_files = FileList["test/unit/*_test.rb"]
  end

  desc "Run acceptance tests"
  Rake::TestTask.new(:acceptance) do |t|
    t.libs << "test"
    t.test_files = FileList["test/acceptance/*_test.rb"]
  end
end

desc "Run all RSpec tests"
RSpec::Core::RakeTask.new(:spec)

desc "Create the database"
task :db do
  require "init"
  DataMapper.auto_upgrade!

  Integrity::Project.all(:last_build_id => nil).each do |project|
    project.last_build = project.sorted_builds.first
    project.raise_on_save_failure = true
    project.save
  end
end

desc "Clean-up build directory"
task :cleanup do
  require "init"
  Integrity::Build.all(:completed_at.not => nil).each { |build|
    dir = Integrity.config.directory.join(build.id.to_s)
    dir.rmtree if dir.directory?
  }
end

namespace :jobs do
  desc "Clear the delayed_job queue."
  task :clear do
    require "init"
    require "integrity/delayed_builder"
    Delayed::Job.delete_all
  end

  desc "Start a delayed_job worker."
  task :work do
    require "init"
    require "integrity/delayed_builder"
    Delayed::Worker.new.start
  end
end

begin
  namespace :resque do
    require "init"
    require "resque/tasks"

    desc "Start a Resque worker for Integrity"
    task :work do
      ENV["QUEUE"] = "integrity"
      Rake::Task["resque:resque:work"].invoke
    end
  end
rescue LoadError
end

desc "Generate HTML documentation."
file "doc/integrity.html" => ["doc/htmlize",
  "doc/integrity.txt",
  "doc/integrity.css"] do |f|
  sh "cat doc/integrity.txt | doc/htmlize > #{f.name}"
end

desc "Re-generate stylesheet"
file "public/integrity.css" => "views/integrity.sass" do |f|
  sh "sass views/integrity.sass > #{f.name}"
end

CLOBBER.include("doc/integrity.html")
