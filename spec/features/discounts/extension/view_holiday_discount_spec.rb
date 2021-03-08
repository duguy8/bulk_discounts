require "rails_helper"

RSpec.describe "When I visit the discounts index page & have created a holiday discount" do
  before :each do
    response = File.open('./fixtures/nader_holidays.json')

    stub_request(:get, "https://date.nager.at/Api/v2/NextPublicHolidays/US").
      to_return(status: 200, body: response)

    @merchant = create(:merchant)
  end

  describe "I should not see a ~Create Discount~ button" do
    it "Next to already created holiday discount should be link" do
      visit merchant_discounts_path(@merchant)

      click_button("Create Discount", :match => :first)
      click_button "Submit"

      within(".upcoming_holidays") do
        expect(page).to have_link("Memorial Day Discount")
      end
    end

    it "Should take me to the holidays discounts show page" do
      visit merchant_discounts_path(@merchant)

      click_button("Create Discount", :match => :first)
      click_button "Submit"

      within(".upcoming_holidays") do
        click_link("Memorial Day Discount")
      end

      save_and_open_page

      expect(page).to have_content("Memorial Day")
      expect(page).to have_content("Quantity Threshold: 2")
      expect(page).to have_content("Percentage Discount: 30")
    end
  end
end
