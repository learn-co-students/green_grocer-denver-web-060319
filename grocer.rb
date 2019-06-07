require 'pry'

def consolidate_cart(cart)
  short_cart ={}
  cart.each do |hashes|
    hashes.each do |item, properties|
      if short_cart[item]
        short_cart[item][:count] += 1
      else
        short_cart[item] ||= properties
        short_cart[item][:count] = 1
      end
    end
  end
  short_cart 
end

def apply_coupons cart, coupons
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
  cons = consolidate_cart(cart)
  cons_coupons = apply_coupons(cons, coupons)
  clear_cons_coup = apply_clearance(cons_coupons)
  total = 0
  clear_cons_coup.each do |item, hash|
    total += hash[:price] * hash[:count]
  end
  total > 100 ? total * 0.9 : total
end

# def checkout(cart, coupons)
#   consolidated_cart = consolidate_cart(cart)
#   couponed_cart = apply_coupons(consolidated_cart, coupons)
#   final_cart = apply_clearance(couponed_cart)
#   total = 0
#   final_cart.each do |name, properties|
#     total += properties[:price] * properties[:count]
#   end
#   total = total * 0.9 if total > 100
#   total
# end