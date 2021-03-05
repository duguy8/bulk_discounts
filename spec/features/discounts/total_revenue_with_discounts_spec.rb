require "rails_helper"

RSpec.describe "When I visit my merchant_invoice_show_page" do
  before :each do
    @merchant = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant.id)
    @discount2 = create(:discount, merchant_id: @merchant.id)

    @invoice = create(:invoice)


    @item = create(:item, merchant_id: @merchant.id)


    @invoice_item = create(:invoice_item, item_id: @item.id, invoice_id: @invoice.id)
  end

  describe "I see that the total revenue for my merchant" do
    it "Includes discounts in the calculation" do
      visit merchant_invoice_path(@merchant, @invoice)
    end
  end
end



# As a merchant
# When I visit my merchant invoice show page
# Then I see that the total revenue for my
# merchant includes bulk discounts in the calculation
