require "rails_helper"

RSpec.describe "When I visit the discounts index page" do
  before :each do
    @merchant = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant.id)
    @discount2 = create(:discount, merchant_id: @merchant.id)
    @discount3 = create(:discount, merchant_id: @merchant.id)
  end

  describe "I see a section ~Upcoming Holidays~ with next 3 upcoming US holidays listed" do
    it "Is from the Next public holidays endpoint in Nager.Date API" do
      visit merchant_discounts_path(@merchant)

      within(".upcoming_holidays") do
        expect(page).to have_content("Upcoming Holiday 1:")
        expect(page).to have_content("Upcoming Holiday 2:")
        expect(page).to have_content("Upcoming Holiday 3:")
      end
    end
  end
end
