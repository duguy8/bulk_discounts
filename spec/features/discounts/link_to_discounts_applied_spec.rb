require "rails_helper"

RSpec.describe "When I visit my merchant_invoice_show_page" do
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

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice.id, quantity: 20, unit_price: 100)
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice.id, quantity: 5, unit_price: 100)
    @invoice_item3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice2.id, quantity: 5, unit_price: 100)
  end

  describe "Next to each invoice item I see a link" do
    it "To the show page of any discounts applied ~if any~" do
      visit merchant_invoice_path(@merchant, @invoice)

      within("#invoice_item-#{@invoice_item1.id}") do
        expect(page).to have_content("Discount Applied: #{@discount1.name}")
        expect(page).to have_link("#{@discount1.name}")
        click_link("#{@discount1.name}")
      end

      expect(current_path).to eq(merchant_discount_path(@merchant, @discount1))
    end

    xit "Does not show link if no discounts were applied" do
      visit merchant_invoice_path(@merchant, @invoice)

      within("#invoice_item-#{@invoice_item3.id}") do
        expect(page).not_to have_content("Discount Applied: #{@discount2.name}")
        expect(page).not_to have_link("#{@discount2.name}")
      end
    end
  end
end
