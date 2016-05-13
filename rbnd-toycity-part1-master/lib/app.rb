require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date

puts "********* NOT DONE *********"

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

def calculate_avg(prices)
  num_prices = prices.count

  calculate_total(prices) / num_prices
end

def calculate_total(prices)
  prices.reduce(0) { |sum, price| sum + price}
end

products_hash["items"].each do |product|
  actual_price      = product["full-price"].to_f
  purchases         = product["purchases"]

  purchase_prices   = purchases.map { |purchase| purchase["price"].to_f }
  discounts         = purchases.map { |purch| actual_price - purch["price"].to_f }

  total_sales       = calculate_total(purchase_prices)
  average_price     = calculate_avg(purchase_prices)
  average_discount  = calculate_avg(discounts)

  puts "#{product["title"]}"
  puts "Retail Price: $#{actual_price}"
  puts "Purchase Count: #{purchases.count}"
  puts "Total Sales: $#{total_sales}"
  puts "Average Price: $#{average_price.round(2)}"
  puts "Average Discount: $#{average_discount.round(2)}"

  puts
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

brands_hash = {}

products_hash["items"].each do |product|
  brand = product["brand"]

  # If brand doesn't exist in hash yet, create
  # the hash to collect brand data
  unless !!brands_hash[brand]
    brands_hash[brand] = {
      "total_toys_stocked"  => 0,
      "toy_prices"    => [],
      "total_revenue" => 0
    }
  end

  product_purchases = product["purchases"].map { |purch| purch["price"].to_f }

  # Populate the brand data
  brands_hash[brand]["total_toys_stocked"]  += 1
  brands_hash[brand]["toy_prices"]          << product["full-price"].to_f
  brands_hash[brand]["total_revenue"]       += calculate_total(product_purchases)
end

brands_hash.each do |brand|
  brand_name = brand.first
  brand_data = brand.last

  total_toys_stocked  = brand_data["total_toys_stocked"]
  average_toy_price   = calculate_avg(brand_data["toy_prices"])
  total_revenue       = brand_data["total_revenue"]

  puts "#{brand_name}"
  puts "Total Toys Stocked: #{total_toys_stocked}"
  puts "Average Price: #{average_toy_price.round(2)}"
  puts "Total Revenue: #{total_revenue.round(2)}"
  puts
end
