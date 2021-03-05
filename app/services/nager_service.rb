class NagerService
  extend GetUrl

  def self.upcoming_holidays
    input = get_data('https://date.nager.at/Api/v2/NextPublicHolidays/US')[0..2]
    Holiday.upcoming(input)
  end
end
