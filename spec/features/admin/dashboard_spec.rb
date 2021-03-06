require "rails_helper"

RSpec.describe "When I visit '/admin' I see the admin dashboard" do
  it "displays dashboard header" do
    VCR.use_cassette("github_information_five") do
    visit admin_index_path

    expect(page).to have_content("This is the Admin Dashboard")
    expect(page).to have_link("Admin Merchants Index")
    expect(page).to have_link("Admin Invoices Index")
    end
  end
end
