require "rails_helper"

RSpec.describe "As a merchant on my dashboard" do
  before :each do
    @merchant = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant.id)
    @discount2 = create(:discount, merchant_id: @merchant.id)
    @discount3 = create(:discount, merchant_id: @merchant.id)
  end

  describe "I see a link to ~View All Discounts" do
    it "Takes me to my discounts index page" do
      visit merchant_dashboard_index_path(@merchant)

      expect(page).to have_link("View All Discounts")

      click_link "View All Discounts"

      expect(current_path).to eq(merchant_discounts_path(@merchant))
    end

    it "I see all my discounts with their percentage & threshold" do
      visit merchant_discounts_path(@merchant)

      expect(page).to have_content(@discount1.name)
      expect(page).to have_content(@discount2.name)
      expect(page).to have_content(@discount3.name)
    end

    it "Each discount includes a link to its show page" do
      visit merchant_discounts_path(@merchant)

      expect(page).to have_link(@discount1.name)
      expect(page).to have_link(@discount2.name)
      expect(page).to have_link(@discount3.name)

      click_link(@discount1.name)

      expect(current_path).to eq(merchant_discount_path(@merchant, @discount1))
    end
  end
end




# As a merchant
# When I visit my merchant dashboard
# Then I see a link to view all my discounts
# When I click this link
# Then I am taken to my bulk discounts index page
# Where I see all of my bulk discounts including their
# percentage discount and quantity thresholds
# And each bulk discount listed includes a link to its show page
