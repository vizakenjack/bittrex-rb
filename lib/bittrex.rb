require 'bittrex/version'
require 'openssl'
require 'json'
require 'httparty'

module Bittrex
  class Request
      BASE_URL = 'https://bittrex.com/api/v1.1'
      attr_reader :api_key, :api_secret

      def initialize(api_key, api_secret)
        @api_key = api_key
        @api_secret = api_secret
      end

      def get(path, params = '')
        begin
          nonce = Time.now.to_i
          final_url = "#{BASE_URL}#{path}?apikey=#{api_key}&nonce=#{nonce}&"+params
          hmac_sign = generate_sign(final_url)

          response = HTTParty.get(final_url, headers: { apisign: hmac_sign })
          handle_response response.body
        rescue Exception => e
          nil
        end
      end

      private

      def generate_sign(url)
        OpenSSL::HMAC.hexdigest('sha512', api_secret, url)
      end

      def handle_response(response)
        json = JSON.parse(response)
        if json['success']
          json['result']
        else
          puts "Request failed: #{json}"
          json['message']
        end
      end
  end

  class Api
    attr_accessor :request

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
