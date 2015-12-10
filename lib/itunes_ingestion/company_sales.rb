require "itunes_ingestion"
require "date"

module ITunesIngestion
class CompanySales
  attr_accessor :today, :sales_per_month
  DAY_FORMAT = "%Y%m%d"
  MONTH_FORMAT = "%Y%m"
  YEAR_FORMAT = "%Y"
  def initialize(email, password, company_id, app_name)
    @today = Date.today
    @sales_per_month = {}
    @app_name = app_name
    @fetcher = ITunesIngestion::Fetcher.new(email, password, company_id)
  end

  def fetch(date, date_type)
    case date_type
    when "Monthly"
      date_string = date.strftime(MONTH_FORMAT)
    when "Yearly"
      date_string = date.strftime(YEAR_FORMAT)
    else
      date_string = date.strftime(DAY_FORMAT)
    end
    begin
      print '.'
      #puts "Getting report for #{date_string}"
      report_data = @fetcher.fetch({report_type: "Summary", date_type: date_type, report_date: date_string})
      update_total(date.strftime(MONTH_FORMAT), report_data) if report_data
    rescue ITunesIngestion::ITunesConnectError
      return false
    end
    true
  end

  def update_total(date_string, report_data)
    @sales_per_month[date_string] ||= 0
    reports = ITunesIngestion::SalesReportParser.parse(report_data)
    reports.each do |report|
      if report[:title] == @app_name && (report[:product_type_id].start_with?("1") || report[:product_type_id].start_with?("F1"))
        @sales_per_month[date_string] += report[:units]
      else
        #puts "#{report[:country_code]}: #{report[:begin_date]} - #{report[:end_date]} (#{report[:product_type_id]}): #{report[:units]}"
      end
    end
  end

  def day_report(nr_of_days)
    (1..nr_of_days).reverse_each do |d|
      day = @today - d
      fetch(day, "Daily")
    end
  end

  def week_report(nr_of_weeks)
    sunday = @today - @today.wday
    (0..nr_of_weeks-1).reverse_each do |d|
      day = sunday - 7*d
      fetch(day, "Weekly")
    end
  end

  def month_reports_as_log_as_available()
    d = 1
    loop do
      month = @today.prev_month(d)
      d += 1
      break unless fetch(month, "Monthly")
    end
  end

  def year_report(nr_of_years)
    (1..nr_of_years).reverse_each do |d|
      year = @today.prev_year(d)
      fetch(year, "Yearly")
    end
  end

  def total_report()
      month_reports_as_log_as_available()
      day_report(@today.mday-1)
      puts ""
      @sales_per_month.keys.sort.each do |k|
        puts "Sales for #{k} is #{@sales_per_month[k]}"
      end
      total = @sales_per_month.values.reduce(:+)
      puts "Total Sales is #{total}"
  end
end
end
