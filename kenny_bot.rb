require 'watir'

class KennyBot
  def initialize(username, password, products)
    @username = username
    @password = password
    @products = products

    @browser = Watir::Browser.new :chrome
    @browser.goto 'https://www.adidas.com/us/myaccount-create-or-login'

    login
    open_products
    puts @browser.title
    
    sleep
  end

  def login
    iframe = @browser.iframe(id: 'loginaccountframe')
    iframe.text_field(id: 'username').set(@username)
    iframe.text_field(id: 'password').set(@password)
    iframe.button(id: 'signinSubmit').click
  end

  def open_products
    @products.each_with_index do |product_page|
      @browser.goto(product_page[:link])
      
      product_page[:product].each do |product|
        begin
          @browser.link(class: 'product-link', data_track: product).click(:command)
        rescue Watir::Exception::UnknownObjectException
          puts "--> Oops! Product number \"#{product}\" may no longer be available on the page!"
        rescue Timeout::Error
          @browser.refresh
          retry
        end
      end
    end
  end
end
