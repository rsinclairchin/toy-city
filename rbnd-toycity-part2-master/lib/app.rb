require 'pp'
require 'json'
require 'date'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

report = open("report.txt", "w")

# Print today's date
report.puts(DateTime.now.strftime('%m/%d/%Y'))

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
    report.puts(line)
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

  def initialize(toy)
    @name = toy["title"]
    @retail_price = toy["full-price"]
    @purchases = toy["purchases"]
    @total_sales = 0
    @purchases.each do |sale|
      @total_sales = @total_sales + sale["price"]
    end
  end

  def total_purchases
    @purchases.length
  end

  def average_price
    @total_sales/@purchases.length
  end

  def discount
    (@retail_price.to_i - average_price).round(2)
  end

  def discount_percent
    (dollar_discount/@retail_price.to_i*100).round(2)
  end

products_hash["items"].each do |toy|

  toy = Product.new(toy)
  report.puts("NAME: #{toy.name}")
  report.puts("RETAIL PRICE: $#{toy.retail_price}")
  report.puts("PURCHASES: #{toy.total_purchases}")
  report.puts("TOTAL AMOUNT OF SALES: $#{toy.total_sales}")
  report.puts("AVERAGE PRICE: $#{toy.total_sales/toy.total_purchases}")
  report.puts("AVERAGE DISCOUNT:")
  report.puts("DOLLARS: $#{toy.discount}")
  report.puts("PERCENTAGE: %#{(toy.discount/toy.retail_price.to_i*100).round(2)}")
  report.puts("*"*30)

end

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

class Brand

  def initialize(products_hash)
    @products_hash = products_hash
    @branded = Hash.new
    organize_by_brand
  end

  def organize_by_brand
    @products_hash["items"].each do |toy|
        !@branded[toy["brand"]] ? @branded[toy["brand"]] = [toy] : @branded[toy["brand"]] << toy
    end
  end

  def print_report
    @branded.keys.each do |key, value|
      puts "BRAND: #{key}"
      puts "TOYS STOCKED: #{@branded[key].count}"
      puts "AVERAGE PRICE: $#{average_price(key)}"
    end
  end

  def average_price(brand)
    total_price = 0
    @branded[brand].each do |toy|
      total_price = total_price + toy["full-price"].to_i
    end
    average_price = total_price/@branded[brand].count
    return average_price
  end

  def total_revenue(brand)

  end

end



branded = Brand.new(products_hash)

# branded.keys.each do |brand|
  pp branded

  report.puts branded.print_report



  total_price = 0
  branded[brand].each do |toy|
    total_price = total_price + toy["full-price"].to_i
  end
  average_price = total_price/toys_stocked

  total_sales = 0
  branded[brand].each do |toy|
    toy["purchases"].each do |purchase|
      total_sales = total_sales + purchase["price"]
    end
  end
  p "TOTAL REVENUE: #{(total_sales - total_price).round(2)}"

  p "*"*30

# end