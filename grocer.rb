require "pry"

def consolidate_cart(cart)
  # code here
  temp = {}
  cart.each do |item|
  	item.each do |name, data|
  		if(!temp[name])
  			temp[name] = data
  			temp[name][:count] = 1
  		else
  			temp[name][:count] += 1
  		end
  	end
  end
  temp
end

def apply_coupons(cart, coupons)
  # code here\
 
  temp = {}
  coupons.each do |coupon|
  	cart.each do |item, data|

  		if(coupon[:item] == item && data[:count] >= coupon[:num])
  			count = data[:count]
  			coupon_count = coupon[:num]

  			data[:count] = count % coupon_count
  			temp[item] = data		
  			new_coupon_count = count/coupon_count

  			temp["#{item} W/COUPON"] = {
  				:price => coupon[:cost],
  				:clearance => data[:clearance],
  				:count => new_coupon_count
  			}
  			
  		else
  			temp[item] = data
  		end
  	end
  end

  if (coupons == [])
  	return cart
  else
	return temp
  end
end

def apply_clearance(cart)
  # code here
  cart.each do |item, data|
  	if (data[:clearance])
  		data[:price] = (data[:price] * 0.80).round(2)
  	end
  end
end

def checkout(cart, coupons)
  # code here
  total = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  apply_clearance(cart)
  cart.each do |item, data|
  	total += data[:price] * data[:count]
  end
  if(total > 100)
  	return total * 0.90
  else
  	return total
  end
end
