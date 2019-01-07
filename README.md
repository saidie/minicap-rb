# minicap-ruby

Ruby interface for fetching Android real-time screen capture data via [openstf/minicap](https://github.com/openstf/minicap).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minicap-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minicap-ruby

## Usage

```ruby
require 'minicap'

ms = Minicap::Stream.new('localhost', 1313)
ms.each.with_index do |jpg_blob, index|
  open("#{index}.jpg", 'wb') { |f| f.write jpg_blob.pack('C*') }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/saidie/minicap-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
