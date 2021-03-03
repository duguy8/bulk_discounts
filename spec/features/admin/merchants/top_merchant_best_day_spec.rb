require 'rails_helper'

RSpec.describe 'the admin merchant index page' do
  describe 'the top 5 merchants section' do
    before :each do
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)

      @item1 = create(:item, merchant_id: @merchant1.id)
      @item2 = create(:item, merchant_id: @merchant1.id)
      @item3 = create(:item, merchant_id: @merchant2.id)
      @item4 = create(:item, merchant_id: @merchant2.id)

      @invoice1 = create(:invoice, created_at: "2013-03-25 09:54:09 UTC")
      @invoice2 = create(:invoice, created_at: "2012-03-17 09:54:09 UTC")
      @invoice3 = create(:invoice, created_at: "2011-03-01 09:54:09 UTC")
      @invoice4 = create(:invoice, created_at: "2020-03-25 09:54:09 UTC")

      @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 1, quantity: 6, unit_price: 100)
      @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id, status: 1, quantity: 2, unit_price: 100)
      @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item3.id, status: 0, quantity: 6, unit_price: 100)
      @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item4.id, status: 2, quantity: 2, unit_price: 100)

      @transactions = create(:transaction, invoice_id: @invoice_item1.invoice.id, result: "success")
      @transactions2 = create(:transaction, invoice_id: @invoice_item2.invoice.id, result: "success")
      @transactions3 = create(:transaction, invoice_id: @invoice_item3.invoice.id, result: "success")
      @transactions4 = create(:transaction, invoice_id: @invoice_item4.invoice.id, result: "success")
  end

    it 'displays the day with the most revenue for each merchant' do
      visit admin_merchants_path

      within("#top_merchants") do
        expect(page).to have_content("Top selling date for #{@merchant1.name} was: #{@merchant1.top_selling_date}")
        expect(page).to have_content("Top selling date for #{@merchant2.name} was: #{@merchant2.top_selling_date}")
      end
      # 1 - invoice1 date
      # 2 - invoice3 date
    end
  end
end
# As an admin,
# When I visit the admin merchants index
# Then next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant.
# And I see a label “Top selling date for was "
#
# Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
