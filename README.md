# LibxmlEnumparse

Welcome to libxml_enumparse! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/libxml_enumparse`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

### OS
It is not easy to prevent libxml-ruby errors on Windows, so currently only Linux is supported. 
It may also work on Mac.

### How to install
Install the gem and add to the application's Gemfile by executing:

    $ bundle add libxml_enumparse

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install libxml_enumparse

## Usage

Generate an instance. The first argument is the XML path, and the second argument is the element name to be extracted. Get an enumerator from the instance and process the retrieved elements sequentially.

```
require 'libxml_enumparse'

enumparse = LibXMLEnumparse::Parser.new('something.xml', 'ElementName')
reader = enumparse.enumerator
reader.each do |elm|
    # Do something for extracted element
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/libxml_enumparse. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/libxml_enumparse/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LibxmlEnumparse project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/libxml_enumparse/blob/master/CODE_OF_CONDUCT.md).
