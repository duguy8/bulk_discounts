require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe "validations" do
    it { should validate_presence_of :status }
  end

  describe "class methods" do
    it "#incomplete_invoices" do
      @merchant1 = create(:merchant)

      @customer1 = create(:customer)

      @item1 = create(:item, merchant_id: @merchant1.id)
      @item2 = create(:item, merchant_id: @merchant1.id)
      @item3 = create(:item, merchant_id: @merchant1.id)
      @item4 = create(:item, merchant_id: @merchant1.id)

      @invoice1 = create(:invoice, created_at: "2013-03-25 09:54:09 UTC")
      @invoice2 = create(:invoice, created_at: "2012-03-17 09:54:09 UTC")
      @invoice3 = create(:invoice, created_at: "2011-03-01 09:54:09 UTC")
      @invoice4 = create(:invoice, created_at: "2020-03-25 09:54:09 UTC")

      @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 1, quantity: 6, unit_price: 100)
      @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id, status: 1, quantity: 5, unit_price: 100)
      @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item3.id, status: 0, quantity: 4, unit_price: 100)
      @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item4.id, status: 2, quantity: 3, unit_price: 100)

      expected = [@invoice3, @invoice2, @invoice1]

      expect(Invoice.incomplete_invoices).to eq(expected)
      expect(Invoice.incomplete_invoices.first).to eq(@invoice3)
      expect(Invoice.incomplete_invoices.last).to eq(@invoice1)
    end
  end
  describe 'instance methods' do
    before :each do
      @merchant1 = create(:merchant)

      @customer1 = create(:customer)

      @item1 = create(:item, merchant_id: @merchant1.id)
      @item2 = create(:item, merchant_id: @merchant1.id)
      @item3 = create(:item, merchant_id: @merchant1.id)
      @item4 = create(:item, merchant_id: @merchant1.id)
      @item5 = create(:item, merchant_id: @merchant1.id)
      @item6 = create(:item, merchant_id: @merchant1.id)
      @item7 = create(:item, merchant_id: @merchant1.id)

      @invoice1 = create(:invoice, created_at: "2013-03-25 09:54:09 UTC", customer_id: @customer1.id)

      @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 1, quantity: 6, unit_price: 100)
      @invoice_item2 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id, status: 2, quantity: 5, unit_price: 100)
      @invoice_item3 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item3.id, status: 2, quantity: 4, unit_price: 100)
      @invoice_item4 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item4.id, status: 0, quantity: 3, unit_price: 100)
      @invoice_item5 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item5.id, status: 2, quantity: 2, unit_price: 100)
      @invoice_item6 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item6.id, status: 1, quantity: 1, unit_price: 100)
      @invoice_item7 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item7.id, status: 2, quantity: 1, unit_price: 100)
    end
    it "#total_revenue" do
      expect(@invoice1.total_revenue).to eq(2200)
    end
  end

  describe "More Instance Methods" do
    it "#apply_discounts example 3" do
      merchant = create(:merchant)

      discount1 = create(:discount, merchant_id: merchant.id, quantity_threshold: 10, percentage_discount: 20)
      discount2 = create(:discount, merchant_id: merchant.id, quantity_threshold: 15, percentage_discount: 30)

      invoice = create(:invoice)

      item1 = create(:item, merchant_id: merchant.id)
      item2 = create(:item, merchant_id: merchant.id)

      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice.id, quantity: 12, unit_price: 100)
      invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice.id, quantity: 15, unit_price: 100)

      expect(invoice.total_revenue).to eq(2010)
    end

    it "#apply_discounts example 4" do
      merchant = create(:merchant)

      discount1 = create(:discount, merchant_id: merchant.id, quantity_threshold: 10, percentage_discount: 20)
      discount2 = create(:discount, merchant_id: merchant.id, quantity_threshold: 15, percentage_discount: 10)

      invoice = create(:invoice)

      item1 = create(:item, merchant_id: merchant.id)
      item2 = create(:item, merchant_id: merchant.id)

      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice.id, quantity: 12, unit_price: 100)
      invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice.id, quantity: 15, unit_price: 100)

      expect(invoice.total_revenue).to eq(2160)
    end

    it "#apply_discounts example 5" do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      discount1 = create(:discount, merchant_id: merchant1.id, quantity_threshold: 10, percentage_discount: 20)
      discount2 = create(:discount, merchant_id: merchant1.id, quantity_threshold: 15, percentage_discount: 30)

      invoice = create(:invoice)

      item1 = create(:item, merchant_id: merchant1.id)
      item2 = create(:item, merchant_id: merchant1.id)
      item3 = create(:item, merchant_id: merchant2.id)

      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice.id, quantity: 12, unit_price: 100)
      invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice.id, quantity: 15, unit_price: 100)
      invoice_item3 = create(:invoice_item, item_id: item3.id, invoice_id: invoice.id, quantity: 15, unit_price: 100)

      expect(invoice.total_revenue).to eq(3510)
    end
  end

  describe "Instance Methods" do
    it "#discount_applied" do
      merchant1 = create(:merchant)

      discount1 = create(:discount, merchant_id: merchant1.id, quantity_threshold: 10, percentage_discount: 20)
      discount2 = create(:discount, merchant_id: merchant1.id, quantity_threshold: 15, percentage_discount: 30)

      invoice = create(:invoice)

      item1 = create(:item, merchant_id: merchant1.id)
      item2 = create(:item, merchant_id: merchant1.id)

      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice.id, quantity: 12, unit_price: 100)
      invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice.id, quantity: 15, unit_price: 100)

      expect(invoice_item1.discount_applied).to eq(discount1)
      expect(invoice_item2.discount_applied).to eq(discount2)
    end
  end
end
