class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    # code for cart request and response
      if req.path.match(/cart/)
          if @@cart == []
            resp.write "Your cart is empty"
          elsif @@cart != []
            @@cart.each do |cart_item|
            resp.write "#{cart_item}\n"
            end  
          end 
      else 
        resp.write "Path Not Found"
      end 

    #solution for /add route
    if req.path.match(/add/)
      add_item = req.params["item"]
      resp.write handle_add(add_item)
    end 

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  #method handles add method
  def handle_add(add_item)
    if @@items.include?(add_item)
      @@cart << add_item
      return "added #{add_item}"
    else 
      return "We don't have that item"
    end 
  end 



end
