require "rails_helper"

RSpec.describe "When I visit my merchant_invoice_show_page" do
  before :each do
    @merchant = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant.id, quantity_threshold: 10, percentage_discount: 20)
    @discount2 = create(:discount, merchant_id: @merchant.id, quantity_threshold: 12, percentage_discount: 10)

    @invoice = create(:invoice)


    @item1 = create(:item, merchant_id: @merchant.id)
    @item2 = create(:item, merchant_id: @merchant.id)

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice.id, quantity: 20, unit_price: 100)
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice.id, quantity: 5, unit_price: 100)
  end

  describe "I see that the total revenue for my merchant" do
    it "Includes discounts in the calculation" do
      visit merchant_invoice_path(@merchant, @invoice)

      expect(page).to have_content("Total Revenue: $2100")
    end
  end
end
