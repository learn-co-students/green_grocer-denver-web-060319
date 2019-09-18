require "pry"
def consolidate_cart(cart)

  cart.each_with_object({}){ |item, hash| 
    item.each{|name, content| 
      hash[name] = content
      if  hash[name][:count] == nil
        hash[name][:count] =  1
      else
        hash[name][:count] +=  1
      end
    }
  }
end

def apply_coupons(cart, coupons)
  coupons.map{ |coupon| 
    if cart.keys.include?(coupon[:item]) && (cart[coupon[:item]][:count] >= coupon[:num])
      cart["#{coupon[:item]} W/COUPON"] = {
          :price => coupon[:cost] / coupon[:num], 
          :clearance => cart[coupon[:item]][:clearance], 
          :count => cart[coupon[:item]][:count]/coupon[:num] * coupon[:num]
        }
        cart[coupon[:item]][:count] = cart[coupon[:item]][:count]  - (cart[coupon[:item]][:count]/coupon[:num] * coupon[:num]) 
    end
    }

    cart
end

def apply_clearance(cart)
  cart.map{|item, sales_info| 
    # binding.pry
    if sales_info[:clearance] == true
      cart[item][:price] = (cart[item][:price]*0.8).round(2)
    end
  }
  cart
end

def checkout(cart, coupons)
  total = 0
  organized_cart = consolidate_cart(cart)
  organized_cart_with_coupons = apply_coupons(organized_cart, coupons)
  organized_cart_with_coupons_and_clearence = apply_clearance(organized_cart_with_coupons)
  organized_cart_with_coupons_and_clearence.keys.map{|item| total += organized_cart[item][:price]*organized_cart[item][:count]}
  
  if total > 100
    total = (total * 0.9).round(2)
  else
    total
  end

end
