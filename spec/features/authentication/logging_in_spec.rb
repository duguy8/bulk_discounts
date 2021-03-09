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
    expect(page).to_not have_button("Register as a User")
    expect(page).to_not have_button("Sign In")
  end

  it "cannot log in with bad credentials" do
    user = User.create(username: "funbucket13", password: "test")

    visit "/"

    click_on "Sign In"

    fill_in :username, with: user.username
    fill_in :password, with: "incorrect password"

    click_on "Sign In"

    expect(current_path).to eq('/signin')

    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  it "Can sign out" do
    visit "/"

    click_on "Register as a User"

    expect(current_path).to eq("/users/new")

    username = "funbucket13"
    password = "test"

    fill_in :username, with: username
    fill_in :password, with: password

    click_on "Create User"
    click_button "Sign Out"

    expect(page).to have_button("Register as a User")
    expect(page).to have_button("Sign In")
  end
end
