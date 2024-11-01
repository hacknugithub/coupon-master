# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!({
  name: 'Juan',
  last_name: 'Doe',
  username: 'eljuandoe',
  email: 'juan@doe.com',
  password: 'juandoe',
})

coupon_book = CouponBook.create!({
  title: 'FAll DISCOUNTS',
  max_number_of_coupons: 50,
  max_coupons_per_user: 5
})

products = Product.create!([
  {title: 'shirt', description: 'this is an awesome shirt', price: 100.00},
  {title: 'camisole', description: 'this is an awesome camisole', price: 150.00},
  {title: 'pants', description: 'this is an awesome pants', price: 200.00},
  {title: 'socks', description: 'this is an awesome socks', price: 100.00},
  {title: 'blouse', description: 'this is an awesome blouse', price: 100.00},
  {title: 'shoes', description: 'this is an awesome shoes', price: 20.00},
  {title: 'hat', description: 'this is an awesome hat', price: 10.00},
  {title: 'coat', description: 'this is an awesome coat', price: 100.00},
  {title: 'shorts', description: 'this is an awesome shorts', price: 100.00},
  {title: 'chinos', description: 'this is an awesome chinos', price: 500.00},
  {title: 'glases', description: 'this is an awesome glases', price: 600.00},
  {title: 't-shirt', description: 'this is an awesome t-shirt', price: 100.00},
  {title: 'gloves', description: 'this is an awesome gloves', price: 55.00},
  {title: 'boxers', description: 'this is an awesome boxers', price: 33.00},
  {title: 'laces', description: 'this is an awesome laces', price: 100.00},
  {title: 'dress', description: 'this is an awesome dress', price: 44.00},
])

coupons = Coupon.create!([
  {title: "FALL 5 OFF", code: "FL5OFFHOTZXC", redeemed: false, discount_percentage: 0.05, coupon_book_id: coupon_book.id, user_id: user.id },
  {title: "FALL 10 OFF", code: "FL10OFFHOTZXC", redeemed: false, discount_percentage: 0.10, coupon_book_id: coupon_book.id, user_id: user.id },
  {title: "FALL 15 OFF", code: "FL15OFFHOTZXC", redeemed: false, discount_percentage: 0.15, coupon_book_id: coupon_book.id, user_id: nil },
  {title: "FALL 20 OFF", code: "FL20OFFHOTZXC", redeemed: false, discount_percentage: 0.20, coupon_book_id: coupon_book.id, user_id: nil },
  {title: "FALL 25 OFF", code: "FL25OFFHOTZXC", redeemed: false, discount_percentage: 0.25, coupon_book_id: coupon_book.id, user_id: nil },
  {title: "FALL 30 OFF", code: "FL30OFFHOTZXC", redeemed: false, discount_percentage: 0.30, coupon_book_id: coupon_book.id, user_id: nil },
  {title: "FALL 35 OFF", code: "FL35OFFHOTZXC", redeemed: false, discount_percentage: 0.35, coupon_book_id: coupon_book.id, user_id: nil },
  {title: "FALL 40 OFF", code: "FL40OFFHOTZXC", redeemed: false, discount_percentage: 0.40, coupon_book_id: coupon_book.id, user_id: nil },
  {title: "FALL 50 OFF", code: "FL50OFFHOTZXC", redeemed: false, discount_percentage: 0.45, coupon_book_id: coupon_book.id, user_id: nil },
  {title: "FALL 55 OFF", code: "FL55OFFHOTZXC", redeemed: false, discount_percentage: 0.50, coupon_book_id: coupon_book.id, user_id: nil },
  {title: "FALL 60 OFF", code: "FL60OFFHOTZXC", redeemed: false, discount_percentage: 0.55, coupon_book_id: coupon_book.id, user_id: nil },
  {title: "FALL 65 OFF", code: "FL65OFFHOTZXC", redeemed: false, discount_percentage: 0.60, coupon_book_id: coupon_book.id, user_id: nil },
])

cart = Cart.create({
  total: 0,
  user_id: user.id
})


cart_items = CartItem.create!([
  {cart_id: cart.id, product_id: products.sample(1).first.id, quantity: 1},
  {cart_id: cart.id, product_id: products.sample(1).first.id, quantity: 2},
  {cart_id: cart.id, product_id: products.sample(1).first.id, quantity: 3},
  {cart_id: cart.id, product_id: products.sample(1).first.id, quantity: 4},
  {cart_id: cart.id, product_id: products.sample(1).first.id, quantity: 5},
])

cart.update!(
  total: cart.total,
  discount_total: 0,
  coupon_id: coupons.sample(1).first.id
)


