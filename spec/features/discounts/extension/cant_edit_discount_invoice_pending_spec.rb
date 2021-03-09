require "rails_helper"

RSpec.describe "When an invoice is pending" do
  before :each do
    response = File.open('./fixtures/nader_holidays.json')

    stub_request(:get, "https://date.nager.at/Api/v2/NextPublicHolidays/US").
      to_return(status: 200, body: response)

    @merchant = create(:merchant)
    @merchant2 = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant.id, quantity_threshold: 10, percentage_discount: 20)
    @discount2 = create(:discount, merchant_id: @merchant2.id, quantity_threshold: 12, percentage_discount: 20)

    @invoice = create(:invoice)
    @invoice2 = create(:invoice)

    @item1 = create(:item, merchant_id: @merchant.id)
    @item2 = create(:item, merchant_id: @merchant2.id)

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice.id, quantity: 20, unit_price: 100, status: 1)
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice2.id, quantity: 20, unit_price: 100, status: 0)
  end

  describe "A merchant should not be able to" do
    it "Delete/edit a discount that applies to any of their items on that invoice" do
      visit merchant_discounts_path(@merchant)

      within(".all_discounts") do
        expect(page).to have_link("Delete Discount")
      end

      visit merchant_discount_path(@merchant, @discount1)

      expect(page).to have_link("Edit this Discount")

      visit merchant_discounts_path(@merchant2)

      within(".all_discounts") do
        expect(page).not_to have_link("Delete Discount")
      end

      visit merchant_discount_path(@merchant2, @discount2)

      expect(page).not_to have_link("Edit this Discount")
    end
  end
end
