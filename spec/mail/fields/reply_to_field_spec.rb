# encoding: utf-8
require 'spec_helper'
# 
# reply-to        =       "Reply-To:" address-list CRLF
# 

describe Mail::ReplyToField do
  
  describe "initialization" do

    it "should initialize" do
      doing { Mail::ReplyToField.new("Reply-To: Mikel") }.should_not raise_error
    end

    it "should mix in the CommonAddress module" do
      Mail::ReplyToField.included_modules.should include(Mail::CommonAddress) 
    end

    it "should accept a string with the field name" do
      t = Mail::ReplyToField.new('Reply-To: Mikel Lindsaar <mikel@test.lindsaar.net>, "Bob Smith" <bob@me.com>')
      t.name.should eq 'Reply-To'
      t.value.should eq 'Mikel Lindsaar <mikel@test.lindsaar.net>, "Bob Smith" <bob@me.com>'
    end

    it "should accept a string without the field name" do
      t = Mail::ReplyToField.new('Mikel Lindsaar <mikel@test.lindsaar.net>, "Bob Smith" <bob@me.com>')
      t.name.should eq 'Reply-To'
      t.value.should eq 'Mikel Lindsaar <mikel@test.lindsaar.net>, "Bob Smith" <bob@me.com>'
    end

  end
  
  # Actual testing of CommonAddress methods oReplyTours in the address field spec file

  describe "instance methods" do
    it "should return an address" do
      t = Mail::ReplyToField.new('Mikel Lindsaar <mikel@test.lindsaar.net>')
      t.formatted.should eq ['Mikel Lindsaar <mikel@test.lindsaar.net>']
    end

    it "should return two addresses" do
      t = Mail::ReplyToField.new('Mikel Lindsaar <mikel@test.lindsaar.net>, Ada Lindsaar <ada@test.lindsaar.net>')
      t.formatted.first.should eq 'Mikel Lindsaar <mikel@test.lindsaar.net>'
      t.addresses.last.should eq 'ada@test.lindsaar.net'
    end

    it "should return one address and a group" do
      t = Mail::ReplyToField.new('sam@me.com, my_group: mikel@me.com, bob@you.com;')
      t.addresses[0].should eq 'sam@me.com'
      t.addresses[1].should eq 'mikel@me.com'
      t.addresses[2].should eq 'bob@you.com'
    end
    
    it "should return the formatted line on to_s" do
      t = Mail::ReplyToField.new('sam@me.com, my_group: mikel@me.com, bob@you.com;')
      t.value.should eq 'sam@me.com, my_group: mikel@me.com, bob@you.com;'
    end
    
    it "should return the encoded line" do
      t = Mail::ReplyToField.new('sam@me.com, my_group: mikel@me.com, bob@you.com;')
      t.encoded.should eq "Reply-To: sam@me.com, \r\n\smy_group: mikel@me.com, \r\n\sbob@you.com;\r\n"
    end
    
  end
  
  
end
