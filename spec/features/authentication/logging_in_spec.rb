require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(username: "funbucket13", password: "test")

    visit "/"

    click_on "Sign In"

    expect(current_path).to eq('/signin')

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on "Sign In"

    expect(current_path).to eq('/')

    expect(page).to have_content("Welcome, #{user.username}")
    expect(page).to have_button("Sign Out")
    expect(page).to_not have_link("Register as a User")
    expect(page).to_not have_link("Sign In")
  end
end
