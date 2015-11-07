# Poppy Rails

[![Gem Version](https://badge.fury.io/rb/poppy-rails.svg)](http://rubygems.org/gems/poppy)
[![Build Status](https://travis-ci.org/damienadermann/poppy-rails.svg?branch=master)](http://travis-ci.org/damienadermann/poppy-rails)

A simple and flexible enumeration implementation for ActiveRecord using [poppy](https://github.com/damienadermann/poppy).


*This release is very alpha. Use at your own risk but I would appreciate feedback.

## Description

Inspired by [enumerate_it](https://github.com/cassiomarques/enumerate_it), Poppy is a simple implementation of enumerations with minimal goodies. Poppy offers a few nice features:

- Enumeration values are objects and can respond to methods
- Works with postreSQL arrays with validations
- Simple API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'poppy-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install poppy-rails

**optional**

Add an initializer that calls

```ruby
ActiveRecord::Base.include(Poppy::ActiveRecord)
``` 

this can be omitted by manually including the adapter in each model that uses Poppy

```ruby
class Sandwhich < ActiveRecord::Base
	include Poppy::ActiveRecord
	
	enumeration :bread, of: Bread
	#...
end
```


## Usage


### Model
```ruby
class Sandwhich < ActiveRecord::Bas
	enumeration :bread, of: Bread
	enumeration :cheeses, as: :array, of: Cheese
end
```
Adding an enumeration to an active_record model will add an inclusion validation. There is no support for nullable enumerations. This is an intended design decision. If you would like this functionality you will need to add a null value
E.g. ` Bread::None `

If the enumeration is an array then all values in the array must be of that enumeration.

### Migrations

Just regular rails migrations

```ruby
class AddJobKindsToJob < ActiveRecord::Migration
  def change
    add_column :sandwhiches, :bread, :string, default: Bread::WHITE
    add_column :sandwhiches, :cheeses, :string, array: true, default: []
  end
end
```

### In the wild

```ruby
> sandwhich = Sandwhich.new(bread: Bread::WHITE, cheeses: [Cheese::CHEDDAR])
> sandwhich.bread
=> Bread::WHITE

> sandwhich.cheeses
=> [Cheese::CHEDDAR]
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Specs depend rely on a postgres database running to test the array support.

```bash
$ createdb poppy-rails-test
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/damienadermann/poppy-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


##TODO
- Add AR initializer
- Add travis.yml
- Add badges
- Add docs

