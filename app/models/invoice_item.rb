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

  # def self.total_revenue
  #    total =
  #    sum("invoice_items.quantity * invoice_items.unit_price").to_i
  #    if !Discount.all.empty?
  #      check_discounts(total)
  #    end
  # end
  #
  # def self.check_discounts(total)
  #   # discount = joins(:discounts)
  #   # .where('invoice_items.quantity >= discounts.quantity_threshold')
  #   # .select('sum(invoice_items.quantity * invoice_items.unit_price)/100 *discounts.percentage_discount AS discount_total')
  #   # .group('discounts.percentage_discount')
  #   # .distinct
  #   # .order('discount_total')
  #   # .last.discount_total.to_i
  #   # total - discount
  # end
end
