# Thailand

Provinces, districts and subdistricts of Thailand

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thailand'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thailand

## Usage

```ruby
require 'thailand'
include Thailand

thailand = Country.instance
=> <#Thailand::Country>
thailand.name
=> "Thailand"
thailand.official_name
=> "Kingdom of Thailand"
thailand.subregions.size
=> 77

bangkok = Province.named 'Bangkok'
=> <#Thailand::Province name="Bangkok">
bangkok.subregions?
=> true

district = District.code '1001'
=> <#Thailand::District name="Phra Nakhon">
district.name
=> "Phra Nakhon"
district.subregions?
=> true

subdistrict = district.subregions.first
=> <#Thailand::Region name="Phra Borom Maha Ratchawang">
subdistrict.name
=> "Phra Borom Maha Ratchawang"
```

## Contributing

1. Fork it ( https://github.com/kiterminal/thailand/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
