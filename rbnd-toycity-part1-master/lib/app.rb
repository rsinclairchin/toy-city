require 'pp'
require 'json'
require 'date'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date
puts DateTime.now.strftime('%m/%d/%Y')

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "


# For each product in the data set:
  # Print the name of the toy
  # Print the retail price of the toy
  # Calculate and print the total number of purchases
  # Calculate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount (% or $) based off the average sales price

  products_hash["items"].each do |toy|

    puts "NAME OF TOY: #{toy["title"]}"

    puts "RETAIL PRICE: $#{toy["full-price"]}"

    puts "TOTAL PURCHASES: #{toy["purchases"].length}"

    total = 0
    toy["purchases"].each do |sale|
      total = total + sale["price"]
    end
    puts "TOTAL AMOUNT OF SALES: $#{total}"

    average_price = total/toy["purchases"].length
    puts "AVERAGE PRICE: $#{average_price}"

    puts "AVERAGE DISCOUNT"
    dollar_discount = (toy["full-price"].to_f - average_price).round(2)
    puts "DOLLARS: $#{dollar_discount}"
    puts "PERCENTAGE: %#{(dollar_discount/toy["full-price"].to_f*100).round(2)}"

    puts "*"*30

  end

	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total revenue of all the brand's toy sales combined

branded = Hash.new

products_hash["items"].each do |toy|
    !branded[toy["brand"]] ? branded[toy['brand']] = [toy] : branded[toy["brand"]] << toy
end

branded.keys.each do |brand|

  puts "BRAND: #{brand}"

  toys_stocked = branded[brand].length
  puts "TOYS STOCKED: #{toys_stocked}"

  total_price = 0
  branded[brand].each do |toy|
    total_price = total_price + toy["full-price"].to_f
  end
  average_price = (total_price/toys_stocked).round(2)
  puts "AVERAGE PRICE: #{average_price}"

  total_sales = 0
  branded[brand].each do |toy|
    toy["purchases"].each do |purchase|
      total_sales = total_sales + purchase["price"]
    end
  end
  puts "TOTAL REVENUE: #{(total_sales).round(2)}"

  puts "*"*30

end