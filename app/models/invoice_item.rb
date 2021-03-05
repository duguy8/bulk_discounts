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

  def self.total_revenue
    # require "pry"; binding.pry
     sum("invoice_items.quantity * invoice_items.unit_price").to_i
  end
end
