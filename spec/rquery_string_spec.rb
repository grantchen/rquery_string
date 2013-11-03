require 'spec_helper'
describe "rquery string" do
  it 'should build and parse simple hash' do
    test_hash = {:a => 1, "b" => "2", :c => 2.5}
    RqueryString.parse(RqueryString.build(test_hash)).should == test_hash
  end

  it 'should build and parse hash value is array' do
    test_hash = {:a => [1,2,3], :b => "1"}
    RqueryString.parse(RqueryString.build(test_hash)).should == test_hash
  end

  it 'should build and parse hash value hash' do
    test_hash = {:a => {:b => "1", :c => 2}}
    RqueryString.parse(RqueryString.build(test_hash)).should == test_hash
  end

  it 'should build and parse complicated hash' do
    test_hash = {:a => {:b => "1", :c => 2}, :d => "ajas", "e" => ["A2",2,3,"1"]}
    RqueryString.parse(RqueryString.build(test_hash)).should == test_hash
  end

  it 'should build and parse hash value hash' do
    test_hash = {:a => {:b => "1", :c => "s"}}
    RqueryString.parse(RqueryString.build(test_hash)).should == test_hash
  end

  it 'should build and parse array value hash' do
    test_hash = {:a => [{:a=>1}, {:b=>1}], :c => "3"}
    test_hash2 = {:a => {:b => [1,2,3]}, :c => "s"}
    RqueryString.parse(RqueryString.build(test_hash)).should == test_hash
    RqueryString.parse(RqueryString.build(test_hash2)).should == test_hash2
  end
end