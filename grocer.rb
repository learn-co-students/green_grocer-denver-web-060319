def consolidate_cart(cart)
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
  coupons.each do |coupon|
    item = coupon[:item]
    if cart[item] && cart[item][:count] >= coupon[:num]
      if cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"][:count] += 1
      else
        cart["#{item} W/COUPON"] = {:price => coupon[:cost], :clearance => cart[item][:clearance], :count => 1}
      end
      cart[item][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, hash|
    if hash[:clearance] == true
      discount = hash[:price].to_f * 20.0 / 100.0
      discounted = hash[:price] - discount
      hash[:price] = discounted.round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
end
