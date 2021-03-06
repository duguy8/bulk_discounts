require "rails_helper"

RSpec.describe "When I visit the discounts index page" do
  before :each do
    response = File.open('./fixtures/nader_holidays.json')

    stub_request(:get, "https://date.nager.at/Api/v2/NextPublicHolidays/US").
      to_return(status: 200, body: response)

    @merchant = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant.id)
    @discount2 = create(:discount, merchant_id: @merchant.id)
    @discount3 = create(:discount, merchant_id: @merchant.id)
  end

  describe "I see a section ~Upcoming Holidays~ with next 3 upcoming US holidays listed" do
    it "Is from the Next public holidays endpoint in Nager.Date API" do
      visit merchant_discounts_path(@merchant)

      within(".upcoming_holidays") do
        expect(page).to have_content("#{NagerService.upcoming_holidays[0].name} on: #{NagerService.upcoming_holidays[0].date}")
        expect(page).to have_content("#{NagerService.upcoming_holidays[1].name} on: #{NagerService.upcoming_holidays[1].date}")
        expect(page).to have_content("#{NagerService.upcoming_holidays[2].name} on: #{NagerService.upcoming_holidays[2].date}")
      end
    end
  end
end
