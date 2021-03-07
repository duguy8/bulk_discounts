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
  scope :revenue, -> {
    sum("invoice_items.quantity
    * invoice_items.unit_price").to_i
  }

  enum status: [ "pending", "packaged", "shipped" ]

  def discount_applied
    discounts.where('quantity_threshold = ? OR quantity_threshold <= ?',
      quantity, quantity)
      .order(percentage_discount: :desc)
      .limit(1)
      .first
  end
end
