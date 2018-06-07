module Bittrex
  class Api
    attr_reader :request

    def initialize(api_key, api_secret)
      @request = Request.new(api_key, api_secret)
    end

    def ticker(market)
      request.get "/public/getticker", "market=#{market}"
    end

    def summaries
      request.get "/public/getmarketsummaries"
    end

    def orderbook(market, type, depth = 50)
      request.get "/public/getorderbook", "market=#{market}&type=#{type}&depth=#{depth}"
    end 

    def market_history(market, count = 10)
      request.get "/public/getmarkethistory", "market=#{market}&count=#{count}"
    end

    def buy(market, quantity, rate = nil)
      if rate
        request.get "/market/buylimit", "market=#{market}&quantity=#{quantity}&rate=#{rate}"
      else
        request.get "/market/buymarket", "market=#{market}&quantity=#{quantity}"
      end
    end

    def sell(market, quantity, rate = nil)
      if rate
        request.get "/market/selllimit", "market=#{market}&quantity=#{quantity}&rate=#{rate}"
      else
        request.get "/market/sellmarket", "market=#{market}&quantity=#{quantity}"
      end
    end

    def cancel(order_id)
      request.get "/market/cancel", "uuid=#{order_id}"
    end

    def open_orders(market = '')
      request.get "/market/getopenorders", "market=#{market}"
    end

    def balances
      request.get "/account/getbalances"
    end

    def balance(currency)
      request.get "/account/getbalance", "currency=#{currency}"
    end

    def order_history(market = nil, count = 5)
      params = market ? "market=#{market}&count=#{count}" : "count=#{count}"
      request.get "/account/getorderhistory", params
    end
  end

end
