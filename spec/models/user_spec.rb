# spec/models/user.rb
require 'rails_helper'

describe User do

  it "is valid" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  # it "is invalid without a firstname" do
  #   Factory.build(:user, first_name: nil).should_not be_valid
  # end

end
