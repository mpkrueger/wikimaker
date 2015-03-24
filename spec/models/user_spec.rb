require 'rails_helper'

describe "initialization" do
  it "creates a user with default role standard" do
    user = User.new(
      name: "Matt", 
      email: "matt@example.com",
      password: "password"
    )
    user.skip_confirmation!
    user.save

    expect(user.role).to eq "standard"
  end
end