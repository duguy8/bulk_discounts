class Invoice < ApplicationRecord
  validates_presence_of :status
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [ "in progress", "cancelled", "completed" ]

  def total_revenue_for_merchant(merchant)
    any_discounts = invoice_items.joins(:discounts).check_quantity
    if !any_discounts.empty?
      total = invoice_items.total_without_discounts(merchant)
      apply_discounts(total, any_discounts)
    else
      invoice_items.total_without_discounts(merchant)
    end
  end

  def total_revenue_for_invoice
    any_discounts = invoice_items.joins(:discounts).check_quantity
    if !any_discounts.empty?
      total = invoice_items.revenue
      apply_discounts(total, any_discounts)
    else
      invoice_items.revenue
    end
  end

  def apply_discounts(total, any_discounts)
    new_total = any_discounts
      .select('invoice_items.*,
      sum(invoice_items.quantity *
      invoice_items.unit_price)/100 *
      discounts.percentage_discount AS discount_total')
      .group('invoice_items.id, discounts.percentage_discount')
      .order('discount_total DESC').uniq
      .sum(&:discount_total).to_i - total
    new_total.abs
  end

  def self.incomplete_invoices
    joins(:invoice_items)
    .where('invoice_items.status != ?', 2)
    .select('invoices.*, invoice_items.invoice_id AS invoice_id,
      invoices.created_at AS invoice_created_at')
      .order('invoice_created_at')
      .distinct
  end
end
