require "collection_errors/version"

module CollectionErrors
end

require 'collection_errors/separate'
require 'collection_errors/unify'

ActiveRecord::Base.send(:include, CollectionErrors::Separate)
ActiveRecord::Base.send(:include, CollectionErrors::Unify)
