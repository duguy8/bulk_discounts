class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity,
                        :unit_price,
                        :status
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  has_many :customers, through: :invoice
  has_many :transactions, through: :invoice
  has_many :discounts, through: :item

  enum status: [ "pending", "packaged", "shipped" ]

  def discount_applied
    expected = discounts.where('quantity_threshold = ? OR quantity_threshold <= ?',
      quantity, quantity)
      .order(percentage_discount: :desc)
      .limit(1)
      .first
  end

  def self.total_revenue
    any_discounts = joins(:discounts)
      .where('invoice_items.quantity >= discounts.quantity_threshold').distinct
    if !any_discounts.empty?
      total = sum("invoice_items.quantity * invoice_items.unit_price").to_i
      apply_discounts(total, any_discounts)
    else
      sum("invoice_items.quantity * invoice_items.unit_price").to_i
    end
  end

  def self.apply_discounts(total, any_discounts)
    discounts = any_discounts
      .select('invoice_items.*,
      sum(invoice_items.quantity *
      invoice_items.unit_price)/100 *
      discounts.percentage_discount AS discount_total')
      .group('invoice_items.id, discounts.percentage_discount')
      .order('discount_total DESC')
      .uniq
    discount = discounts.sum(&:discount_total).to_i
    total - discount
  end
end
