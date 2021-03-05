require "rails_helper"

RSpec.describe "As a merchant when I visit a discount show page" do
  before :each do
    @merchant = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant.id)
    @discount2 = create(:discount, merchant_id: @merchant.id)
    @discount3 = create(:discount, merchant_id: @merchant.id)
  end

  describe "I see the discounts quantity threshold & percentage discount" do
    it "Shows these attributes" do
      visit merchant_discount_path(@merchant, @discount1)

      expect(page).to have_content(@discount1.name)
      expect(page).to have_content(@discount1.quantity_threshold)
      expect(page).to have_content(@discount1.percentage_discount)
    end
  end
end
