# CollectionErrors

CollectionErrors provides custom validation error building for collections in your ActiveRecord model.

When you have validation errors in collections, you generally get error with key such as "children.name". Sometimes this is not good because you can't show detailed messages to your users because this key is shared between all elements in the collection.

CollectionErrors gives alternatives to that.

## Installation

Add this line to your application's Gemfile:

    gem 'collection_errors'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install collection_errors

## Usage

CollectionErrors adds 2 types of validation error building for collection in your Rails application.

### Separate way

When you have validation errors in collections, you generally get error with key such as "children.name".

You can change this by calling separate_errors_on method in your model class.

    has_many :items
    separate_errors_on :items

Then you can get error messages like "Item 1 name is invalid".

You can cange the translation by setting 'collection_error' key. For example,

    en
      errors
        messages
          collection_error: "%{collection_name} %{index} : %{message}"

By default, index will count objects as well those are marked for destruction.
You can ignore those objects by specifying :ignore_marked_for_destruction option.

    has_many :items
    separate_errors_on :items, :ignore_marked_for_destruction => true

### Unify

Or you may want to get simply one message for one collection.

You can get an invalid error for the collection using unify_errors_on.

  has_many :items
  unify_errors_on: items

### Limitation

This gem is for ActiveRecord and it requires errors#delete. If you are using too old Rails, adding delete mtheod will help.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
