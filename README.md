# Ecospec
![image](https://user-images.githubusercontent.com/931048/187340551-d6903624-e895-4fcc-b488-fdb90bb16dba.png)

**Beta:** This library is still under development and should not be considered ready for production

Ecospec lets you efficently test your rails applications by only running relevant specs for the changes introduced in the current branch. 

Because Ruby is a dynamic language, it can be difficult to fully establish the dependencies of the code involved. Ecospec simplifies the problem by instead determining what tests must run for a given set of changes, in accordance with a custom configuration you define.

For example: If you change a controller, you probably don't need to run any of your model tests. Likewise, if you change a user model, you probably don't need to test the sorting of posts.

Other changes, such as those to the readme.md of a project, do not need any tests at all in order to be merged. 

Ecospec takes a conservative approach: If you don't ignore the directory/file, and don't have a rule for it, the entire test suite will run. Only when you have exlicitly specified that a file or directory is safe to ignore via patter matching, or what also should run if any of its contents change, does ecospec generate a list of files. 

And for any change made in app/, it's spec will be looked for in spec/ and added to the tests to run if it exists. This means if you add `app/presenters` as a matching rule with no additional details, then any files changed within will also require their associated spec (and not the entire test suite)


## Suggestions

- Given the reach of Models in a typical codebase, you may want to be liberal in running tests for these changes. 
- be careful with any instances where intergration tests are skipped. Be mindful of what they actually test and if you want the entire test suite to be running for their changes. 
- both the matching and related_specs are regex, allowing you express custom test matching. 
- lean towards overtesting
- avoid file-specific matching and rely on patterns/directory matching. 


## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ecospec

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install ecospec

## Usage

create a `config/ecospec.yml` file with content like the following:
```ruby
ignore:
  - "\.md$"
always_run:
  - "acceptance/"
definitions:
  Gemfile:
    include_specs:
      - spec/system
  app/assets:
    include_specs:
      - spec/system
  app/channels:
  app/models:
    include_specs:
      - spec/
```

each key in `ignore` and `definitions` is a regex, as well as each `included_specs` value. You'll likely want an entry for each value from running `ls -1 app/`. if you specify patterns in `always_run` those specs will always be among the specs executed regardless of any file changes. 

next,update your branch with main (if it is not already)

now run `bundle exec ecospec` to see a list of specs that should be ran, based on the changes in your branch. you'll also see how effective it was with output like `running 2/1683 specs (99.9% reduction in specs ran)`

To run the specs, you can run 
```bash
rspec $(bundle exec ecospec)
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ecospec.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
