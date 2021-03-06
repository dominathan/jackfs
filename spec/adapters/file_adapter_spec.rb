require File.dirname(__FILE__) + '/../spec_helper'


describe "Jackfs File Adapter" do
  before(:each) do
    YAML.should_receive(:load_file).and_return("test" => {
      "adapter" => "file",
      "location" => 'tmp'
    })
    root = File.dirname(__FILE__) + '/..'

    @fa = Jackfs::FileAdapter.new(root, :test)
  end

  it "should save a file to a configured location" do
    Jackfs::FileAdapter.should be_truthy
    @fa.location.should == "tmp"
  end

  it "should save the file in the location using the given name" do
    @fa.store(File.open(File.dirname(__FILE__) + '/../fixtures/test.pdf', 'r'),"COOLBEANS").should == "COOLBEANS"
  end

  it "should get a file from a configured location" do
    f = File.open(File.dirname(__FILE__) + '/../fixtures/test.pdf', 'r')
    @fa.store(File.open(File.dirname(__FILE__) + '/../fixtures/test.pdf', 'r'),"COOLBEANS").should == "COOLBEANS"
    orig = File.open(File.dirname(__FILE__) + '/../fixtures/test.pdf', 'r')
    @fa.get("COOLBEANS").read.length.should == orig.read.length
  end
end
