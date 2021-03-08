require "rails_helper"

RSpec.describe "When I visit the discounts index page & have created a holiday discount" do
  before :each do
    response = File.open('./fixtures/nader_holidays.json')

    stub_request(:get, "https://date.nager.at/Api/v2/NextPublicHolidays/US").
      to_return(status: 200, body: response)

    @merchant = create(:merchant)
  end

  describe "I should not see a ~Create Discount~ button" do
    it "Next to already created holiday discount should be linke" do
      visit merchant_discounts_path(@merchant)

      click_button("Create Discount", :match => :first)
      click_button "Submit"
      save_and_open_page

      within(".upcoming_holidays") do
        expect(page).to have_link("Memorial Day Discount")
      end
    end

    it "Should take me to the holidays discounts show page"
  end
end

# As a merchant (if I have created a holiday
#   discount for a specific holiday),
# when I visit the discount index page,
# within the Upcoming Holidays section I
# should not see the button to 'create a discount'
# next to that holiday,
# instead I should see a view discount link.
# When I click the link I am taken to the
# discount show page for that holiday discount.
