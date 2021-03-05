require "rails_helper"

RSpec.describe "As a merchant on my discounts index" do
  before :each do
    @merchant = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant.id)
    @discount2 = create(:discount, merchant_id: @merchant.id)
    @discount3 = create(:discount, merchant_id: @merchant.id)
  end

  describe "There is a link next to each discount to delete it" do
    it "Takes me back to index with discount no longer listed" do
      visit merchant_discounts_path(@merchant)

      within("#discount-#{@discount1.id}") do
        expect(page).to have_link("Delete Discount")
        click_link "Delete Discount"
      end

      save_and_open_page

      expect(current_path).to eq(merchant_discounts_path(@merchant))
      expect(page).to have_content("#{@discount1.name} Deleted Succesfully")

      within(".all_discounts") do
        expect(page).to have_content(@discount2.name)
        expect(page).to have_content(@discount3.name)
        expect(page).not_to have_content(@discount1.name)
      end
    end
  end
end
