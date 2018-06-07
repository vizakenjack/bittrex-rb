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
end
