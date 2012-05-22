require 'spec_helper'
require 'integrity'

Integrity.configure { |c|
  c.database  = "sqlite3:db/test.db"
  c.directory = File.expand_path(File.dirname(__FILE__) + "/../tmp")
  c.base_url  = "http://www.example.com"
  c.log       = "test.log"
  c.username  = "admin"
  c.password  = "test"
}
Integrity::App.disable(:build_all)
Thread.abort_on_exception = true
DataMapper.auto_migrate!

module Integrity
  describe Build do
    describe "#human_status" do
      subject { Build.new }

      before(:each) do
        subject.stub(:status).and_return(status)
        subject.stub(:sha1_short).and_return("<commit>")
      end

      context "when successful" do
        let(:status) { :success }
        specify { subject.human_status.should eq "Built <commit> successfully" }
      end

      context "when unsuccessful" do
        let(:status) { :failed }
        its(:human_status) { should eq "Built <commit> and failed" }
      end

      context "when pending" do
        let(:status) { :pending }
        its(:human_status) { should eq "<commit> hasn't been built yet" }
      end

      context "when building" do
        let(:status) { :building }
        its(:human_status) { should eq "<commit> is building" }
      end
    end
  end
end
