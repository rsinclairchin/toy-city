require 'pp'
require 'json'
require 'date'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

$report = open("report.txt", "w")

# Print today's date
$report.puts(DateTime.now.strftime('%m/%d/%Y'))

ascii_prods = [
 "                     _            _       ",
 "                    | |          | |      ",
 " _ __  _ __ ___   __| |_   _  ___| |_ ___ ",
 "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|",
 "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\",
 "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/",
 "| |                                       ",
 "|_|                                       "
]

def print_ascii(ascii)
  ascii.each do |line|
    $report.puts(line)
  end
end

print_ascii(ascii_prods)

# For each product in the data set:
  # Print the name of the toy
  # Print the retail price of the toy
  # Calculate and print the total number of purchases
  # Calculate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount (% or $) based off the average sales price

  def name(toy)
    toy["title"]
  end

  def retail_price(toy)
    toy["full-price"].to_f
  end

  def purchases(toy)
    toy["purchases"]
  end

  def total_purchases(toy)
    toy["purchases"].length
  end

  def total_sales(toy)
    total = 0
    toy["purchases"].each do |sale|
      total = total + sale["price"]
    end
    return total
  end

  def average_price(toy)
    total_sales(toy)/total_purchases(toy)
  end

  def discount(toy)
    (retail_price(toy) - average_price(toy)).round(2)
  end

  def discount_percent(toy)
    (discount(toy)/retail_price(toy)*100).round(2)
  end

  def products_report(products_hash)

    products_hash["items"].each do |toy|

      $report.puts("NAME: #{name(toy)}")
      $report.puts("RETAIL PRICE: $#{retail_price(toy)}")
      $report.puts("PURCHASES: #{total_purchases(toy)}")
      $report.puts("TOTAL AMOUNT OF SALES: $#{total_sales(toy)}")
      $report.puts("AVERAGE PRICE: $#{average_price(toy)}")
      $report.puts("AVERAGE DISCOUNT:")
      $report.puts("DOLLARS: $#{discount(toy)}")
      $report.puts("PERCENTAGE: %#{(discount_percent(toy)).round(2)}")
      $report.puts("*"*30)

    end

  end

products_report(products_hash)

ascii_brands =
	[" _                         _     ",
	 "| |                       | |    ",
	 "| |__  _ __ __ _ _ __   __| |___ ",
	 "| '_ \\| '__/ _` | '_ \\ / _` / __|",
	 "| |_) | | | (_| | | | | (_| \\__ \\",
	 "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"]

print_ascii(ascii_brands)

# For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total revenue of all the brand's toy sales combined

  def organize_by_brand(products_hash)
    branded = Hash.new
    products_hash["items"].each do |toy|
        !branded[toy["brand"]] ? branded[toy["brand"]] = [toy] : branded[toy["brand"]] << toy
    end
    return branded
  end

  def average_price(brand)
    total = 0
    $brands[brand].each do |toy|
      total = total + toy["full-price"].to_f
    end
    average_price = (total / $brands[brand].count).round(2)
  end

  def total_revenue(brand)
    total = 0
    $brands[brand].each do |toy|
      toy["purchases"].each do |purchase|
        total = total + purchase["price"]
      end
    end
    return total.round(2)
  end

  def brands_report(brands_hash)
    pp $brands
    brands_hash.keys.each do |key, value|
      $report.puts "BRAND: #{key}"
      $report.puts "TOYS STOCKED: #{brands_hash[key].count}"
      $report.puts "AVERAGE PRICE: $#{average_price(key)}"
      $report.puts "TOTAL REVENUE: $#{total_revenue(key)}"
      $report.puts "*"*30
    end
  end

  $brands = organize_by_brand(products_hash)
  brands_report($brands)