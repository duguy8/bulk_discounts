require "rails_helper"

RSpec.describe "When I visit the discounts index page" do
  before :each do
    response = File.open('./fixtures/nader_holidays.json')

    stub_request(:get, "https://date.nager.at/Api/v2/NextPublicHolidays/US").
      to_return(status: 200, body: response)

    @merchant = create(:merchant)
  end

  describe "In the ~Holiday Discounts~ section" do
    it "I see a ~Create Discount~ next to each upcoming holiday" do
      visit merchant_discounts_path(@merchant)

        expect(page).to have_button("Create Discount")
    end

    it "When I click the button it takes me to a new discount form" do
      visit merchant_discounts_path(@merchant)

      click_button("Create Discount", :match => :first)

      expect(page).to have_button("Submit")
    end

    it "Form is pre-populated with this stuff" do
      visit merchant_discounts_path(@merchant)

      click_button("Create Discount", :match => :first)

      expect(find_field(:discount_name).value).to eq("Memorial Day Discount")
      expect(find_field(:discount_quantity_threshold).value).to eq("2")
      expect(find_field(:discount_percentage_discount).value).to eq("30")
    end

    it "Can be left as is" do
      visit merchant_discounts_path(@merchant)

      click_button("Create Discount", :match => :first)
      click_button "Submit"

      expect(current_path).to eq(merchant_discounts_path(@merchant))

      within(".all_discounts") do
        expect(page).to have_content("Memorial Day Discount")
        expect(page).to have_content("Quantity Threshold: 2")
        expect(page).to have_content("Percentage Discount: 30")
      end
    end

    it "Or modified" do
      visit merchant_discounts_path(@merchant)

      click_button("Create Discount", :match => :first)

      fill_in :discount_name, with: "New Discount"
      fill_in :discount_quantity_threshold, with: 10
      fill_in :discount_percentage_discount, with: 20
      click_button "Submit"

      expect(current_path).to eq(merchant_discounts_path(@merchant))

      within(".all_discounts") do
        expect(page).to have_content("New Discount")
        expect(page).to have_content("Quantity Threshold: 10")
        expect(page).to have_content("Percentage Discount: 20")
      end
    end
  end
end
