#! /usr/bin/env ruby

require 'spec_helper'

describe Puppet::Type.type(:compellent_volume_map) do

  let :resource do
    described_class.new(
    :name          		=> 'Test_Volume_Test',
    :ensure        		=> 'present',
    :boot				      => :true,
    :volumefolder 		=> '',
    :serverfolder			=> '',
    :servername		    => 'Test_Server',
    :lun          		=> '',
    :localport		    => '',
    :force		        => true,
    :singlepath       => true,
    :readonly         => true
    )
  end

  it "should have name as its keyattribute" do
    described_class.key_attributes.should == [:name]
  end

  describe "when validating attributes" do
    [:name].each do |param|
      it "should hava a #{param} parameter" do
        described_class.attrtype(param).should == :param
      end
    end
  end

  describe "when validating values" do

    describe "for name" do
      it "should allow a valid mapping name where ensure is present" do
        described_class.new(:name => 'Test_Volume_Test', :ensure => 'present')[:name].should == 'Test_Volume_Test'
      end

      it "should allow a valid mapping name where ensure is absent" do
        described_class.new(:name => 'Test_Volume_Test', :ensure => 'absent')[:name].should == 'Test_Volume_Test'
      end
    end

    describe "for ensure" do
      it "should allow present" do
        described_class.new(:name => 'Test_Volume_Test', :ensure => 'present')[:ensure].should == :present
      end

      it "should allow absent" do
        described_class.new(:name => 'Test_Volume_Test', :ensure => 'absent')[:ensure].should == :absent
      end

      it "should not allow something else" do
        expect { described_class.new(:name => 'newvolThree', :ensure => 'foo') }.to raise_error Puppet::Error, /Invalid value/
      end
    end

  end
end
