require 'dotenv'
require_relative 'kenny_bot'

Dotenv.load('configs.env')

# -- Product Configurations
PRODUCTS = [
  { link: 'https://www.adidas.com/us/nmd-shoes',
    product: ['BY1888', 'BB3684']},
  { link: 'http://www.adidas.com/us/men-new_arrivals',
    product: ['BH9328']}
]
# --

KennyBot.new(ENV['USERNAME'], ENV['PASSWORD'], PRODUCTS)

