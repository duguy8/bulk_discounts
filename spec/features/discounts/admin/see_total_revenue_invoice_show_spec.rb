require "rails_helper"

RSpec.describe "When I visit an admin/invoice show page" do
  before :each do
    @merchant = create(:merchant)
    @merchant2 = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant.id, quantity_threshold: 10, percentage_discount: 20)
    @discount2 = create(:discount, merchant_id: @merchant.id, quantity_threshold: 12, percentage_discount: 10)
    @discount3 = create(:discount, merchant_id: @merchant2.id, quantity_threshold: 10, percentage_discount: 20)

    @invoice = create(:invoice)
    @invoice2 = create(:invoice)

    @item1 = create(:item, merchant_id: @merchant.id)
    @item2 = create(:item, merchant_id: @merchant.id)

    @item3 = create(:item, merchant_id: @merchant2.id)
    @item4 = create(:item, merchant_id: @merchant2.id)

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice.id, quantity: 20, unit_price: 100)
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice.id, quantity: 5, unit_price: 100)
    @invoice_item3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice2.id, quantity: 5, unit_price: 100)
    @invoice_item4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice2.id, quantity: 5, unit_price: 100)
  end

  describe "I see that the total revenue for that invoice" do
    it "Includes discounts in the calculation" do
      visit admin_invoice_path(@invoice)

      expect(page).to have_content("Total Invoice Revenue with Discounts: $2100")
    end

    it "Should not apply discount if quantity threshold is not met" do
      visit admin_invoice_path(@invoice2)

      expect(page).to have_content("Total Invoice Revenue with Discounts: $1000")
    end
  end
end
