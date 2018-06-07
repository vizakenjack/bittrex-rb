# Bittrex

This gem allows you to connect and send requests to Bittrex exchange.

## Example

    client = Bittrex::Api.new("API_KEY", "API_SECRET")

    client.summaries

    cclient.balances

    client.balance('BTC')

    client.ticker('USD-BTC')

    client.orderbook('USD-BTC', 'buy', 50)

    client.market_history('USD-BTC', 10)

    client.buy('USD-BTC', 1, 7500)

    client.sell('USD-BTC', 1, 10000)

    client.cancel(order_id)

    client.open_orders('USD-BTC')

    client.order_history('USD-BTC', 5)


## Installation

Add this line to your application's Gemfile:

    gem 'bittrex-rb', git: 'git://github.com/vizakenjack/ruby-bittrex-api.git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bittrex-rb

Require it at the top of the script:

    $ require 'bittrex-rb'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
