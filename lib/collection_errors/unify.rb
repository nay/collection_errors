module CollectionErrors
  module Unify
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def unify_errors_on(*args)
        args.each do |collection_name|
          method_name = "unify_errors_on_#{collection_name}"

          define_method method_name do

            # Remove 'collection_name.xxx' attributes from errors
            targets = []
            errors.each do |attribute, message|
              targets << attribute if attribute.to_s =~ /^#{collection_name}\./
            end
            targets.each{|k| errors.delete(k) }

            # Add original errors
            errors.add(collection_name, :invalid) if targets.any?
          end

          after_validation method_name
        end
      end
    end
  end
end
