require "rails_helper"

RSpec.describe "As a merchant when I visit a discount show page" do
  before :each do
    @merchant = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant.id)
  end

  describe "I see a link to ~Edit this Discount" do
    it "It takes me to a /edit page with a form to edit discount" do
      visit merchant_discount_path(@merchant, @discount1)

      expect(page).to have_link("Edit this Discount")

      click_link "Edit this Discount"

      expect(current_path).to eq(edit_merchant_discount_path(@merchant, @discount1))
    end

    it "Attributes are pre-populated, and when I change all info it updates" do
      visit edit_merchant_discount_path(@merchant, @discount1)

      expect(find_field('Name').value).to eq(@discount1.name)

      fill_in :discount_name, with: "518345adf"
      fill_in :discount_quantity_threshold, with: 20
      fill_in :discount_percentage_discount, with: 10
      click_button "Update Discount"

      expect(current_path).to eq(merchant_discount_path(@merchant, @discount1))
      expect(page).to have_content("518345adf")
      expect(page).to have_content(20)
      expect(page).to have_content(10)
    end

    it "When I only update one attribute it still updates" do
      visit edit_merchant_discount_path(@merchant, @discount1)

      fill_in :discount_quantity_threshold, with: 20
      click_button "Update Discount"

      expect(page).to have_content(20)
      expect(page).to have_content(@discount1.percentage_discount)
      expect(page).to have_content(@discount1.name)
    end

    it "When I incorrectly fill out form I see error" do
      visit edit_merchant_discount_path(@merchant, @discount1)

      fill_in :discount_name, with: ""
      click_button "Update Discount"

      expect(page).to have_content("Name can't be blank")
    end
  end
end
