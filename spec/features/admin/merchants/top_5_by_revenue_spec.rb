require "rails_helper"

RSpec.describe "When I visit the admin merchants index" do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @merchant5 = create(:merchant)
    @merchant6 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant2.id)
    @item3 = create(:item, merchant_id: @merchant3.id)
    @item4 = create(:item, merchant_id: @merchant4.id)
    @item5 = create(:item, merchant_id: @merchant5.id)
    @item6 = create(:item, merchant_id: @merchant6.id)

    @invoice1 = create(:invoice)
    @invoice2 = create(:invoice)
    @invoice3 = create(:invoice)
    @invoice4 = create(:invoice)
    @invoice5 = create(:invoice)
    @invoice6 = create(:invoice)

    @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 1, quantity: 6, unit_price: 100)
    @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id, status: 1, quantity: 5, unit_price: 100)
    @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item3.id, status: 0, quantity: 4, unit_price: 100)
    @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item4.id, status: 2, quantity: 3, unit_price: 100)
    @invoice_item5 = create(:invoice_item, invoice_id: @invoice5.id, item_id: @item5.id, status: 0, quantity: 2, unit_price: 100)
    @invoice_item6 = create(:invoice_item, invoice_id: @invoice6.id, item_id: @item6.id, status: 2, quantity: 1, unit_price: 100)

    @transactions = create(:transaction, invoice_id: @invoice_item1.invoice.id, result: "success")
    @transactions2 = create(:transaction, invoice_id: @invoice_item2.invoice.id, result: "success")
    @transactions3 = create(:transaction, invoice_id: @invoice_item3.invoice.id, result: "success")
    @transactions4 = create(:transaction, invoice_id: @invoice_item4.invoice.id, result: "success")
    @transactions5 = create(:transaction, invoice_id: @invoice_item5.invoice.id, result: "success")
    @transactions6 = create(:transaction, invoice_id: @invoice_item6.invoice.id, result: "failed")
  end

  describe "I see the names of top 5 merchants by total revenue" do
    it "Shows only the top 5" do
      visit admin_merchants_path

      within("#top_merchants") do
        expect(@merchant1.name).to appear_before(@merchant2.name)
        expect(@merchant2.name).to appear_before(@merchant3.name)
        expect(@merchant3.name).to appear_before(@merchant4.name)
        expect(@merchant4.name).to appear_before(@merchant5.name)
        expect(@merchant1.name).to appear_before(@merchant5.name)
        expect(page).not_to have_content(@merchant6.name)
      end
    end
    it "merchant names are links to associated admin merchant show page" do
      visit admin_merchants_path

      within("#top_merchants") do
        expect(page).to have_link("#{@merchant1.name}")
        expect(page).to have_link("#{@merchant2.name}")
        expect(page).to have_link("#{@merchant3.name}")
      end
    end
    it 'displays the total associated revenue by each merchant' do
      visit admin_merchants_path

      within("#top_merchants") do
        expect(page).to have_content("Total Revenue: $600")
        expect(page).to have_content("Total Revenue: $500")
        expect(page).to have_content("Total Revenue: $400")
        expect(page).to have_content("Total Revenue: $300")
        expect(page).to have_content("Total Revenue: $200")
      end
    end
  end
end
