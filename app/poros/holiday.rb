class Holiday
  attr_reader :date,
              :name

  def initialize(data)
    @date = data[:date]
    @name = data[:name]
  end

  def is_a_discount
    Discount.where("name like ?", "%#{name}%").pluck(:id)
  end

  def self.upcoming(input)
    input.map do |endpoint|
      Holiday.new(endpoint)
    end
  end
end
