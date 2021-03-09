require "rails_helper"

RSpec.describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :quantity_threshold }
    it { should validate_presence_of :percentage_discount }
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "instance methods" do
    it "#pending_invoices" do
      @merchant = create(:merchant)
      @merchant2 = create(:merchant)

      @discount1 = create(:discount, merchant_id: @merchant.id, quantity_threshold: 10, percentage_discount: 20)
      @discount2 = create(:discount, merchant_id: @merchant2.id, quantity_threshold: 12, percentage_discount: 20)

      @invoice = create(:invoice, status: 1)
      @invoice2 = create(:invoice, status: 0)

      @item1 = create(:item, merchant_id: @merchant.id)
      @item2 = create(:item, merchant_id: @merchant2.id)

      @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice.id, quantity: 20, unit_price: 100, status: 1)
      @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice2.id, quantity: 20, unit_price: 100, status: 0)

      expect(@discount1.pending_invoices.length).to eq 0
      expect(@discount2.pending_invoices.length).to eq 1
    end
  end
end
