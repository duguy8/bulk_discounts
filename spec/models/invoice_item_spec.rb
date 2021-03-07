require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_many(:merchants).through(:item) }
    it { should have_many(:customers).through(:invoice) }
    it { should have_many(:transactions).through(:invoice) }
    it { should have_many(:discounts).through(:item) }
  end

  describe "validations" do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end

  describe "instance methods" do
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

    it "#discount_applied" do
      expect(@invoice_item1.discount_applied).to eq(@discount1)
      expect(@invoice_item2.discount_applied).to be nil
      expect(@invoice_item3.discount_applied).to be nil
    end
  end
end
