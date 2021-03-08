require "rails_helper"

RSpec.describe "As a merchant on my discounts index" do
  before :each do
    response = File.open('./fixtures/nader_holidays.json')

    stub_request(:get, "https://date.nager.at/Api/v2/NextPublicHolidays/US").
      to_return(status: 200, body: response)

    @merchant = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant.id)
    @discount2 = create(:discount, merchant_id: @merchant.id)
    @discount3 = create(:discount, merchant_id: @merchant.id)
  end

  describe "I see a link to create a new discount" do
    it "takes me to a /new page where I see a form to add a new discount" do
      visit merchant_discounts_path(@merchant)

      expect(page).to have_link("Create a new Discount")

      click_link "Create a new Discount"

      expect(current_path).to eq(new_merchant_discount_path(@merchant))
    end

    it "takes me back to index after filling out where I see new discount" do
      visit new_merchant_discount_path(@merchant)

      fill_in :discount_name, with: "Great Discount!"
      fill_in :discount_quantity_threshold, with: 12
      fill_in :discount_percentage_discount, with: 20
      click_button "Create Discount"

      expect(current_path).to eq(merchant_discounts_path(@merchant))
      expect(page).to have_content("Great Discount! Created Succesfully")
      expect(page).to have_content("Great Discount!")
      expect(page).to have_content("12")
      expect(page).to have_content("20")
    end

    it "renders new form if I dont enter valid data" do
      visit new_merchant_discount_path(@merchant)

      fill_in :discount_name, with: ""
      fill_in :discount_quantity_threshold, with: 12
      fill_in :discount_percentage_discount, with: 20
      click_button "Create Discount"

      expect(page).to have_content("Name can't be blank")
    end
  end
end
