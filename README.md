[![Gem Version](https://badge.fury.io/rb/thailand.svg)](http://badge.fury.io/rb/thailand)
[![Dependency Status](https://gemnasium.com/kiterminal/thailand.svg)](https://gemnasium.com/kiterminal/thailand)
[![Build Status](https://travis-ci.org/kiterminal/thailand.svg?branch=master)](https://travis-ci.org/kiterminal/thailand)
[![Coverage Status](https://coveralls.io/repos/kiterminal/thailand/badge.svg?branch=master)](https://coveralls.io/r/kiterminal/thailand?branch=master)
[![Code Climate](https://codeclimate.com/github/kiterminal/thailand/badges/gpa.svg)](https://codeclimate.com/github/kiterminal/thailand)

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
