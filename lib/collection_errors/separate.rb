module CollectionErrors
  module Separate
    def self.included(base)
      base.extend(ClassMethods)
    end

    private
    def generate_error_message_for_collection_element(collection_name, index, message)
      type = :collection_error
      defaults = self.class.lookup_ancestors.map do |klass|
        [ :"#{self.class.i18n_scope}.errors.models.#{klass.model_name.i18n_key}.attributes.#{collection_name}.#{type}",
          :"#{self.class.i18n_scope}.errors.models.#{klass.model_name.i18n_key}.#{type}" ]
      end
      defaults << :"#{self.class.i18n_scope}.errors.messages.#{type}"
      defaults << :"errors.attributes.#{collection_name}.#{type}"
      defaults << :"errors.messages.#{type}"
      defaults << "%{collection_name}%{index} %{message}"

      defaults.compact!
      defaults.flatten!

      I18n.translate(defaults.shift, :collection_name => self.class.human_attribute_name(collection_name), :index => index, :original_message => message, :default => defaults)
    end

    module ClassMethods
      def separate_errors_on(*args)
        options = {:ignore_marked_for_destruction => false}.merge(args.extract_options!)

        args.each do |collection_name|
          method_name = "separate_errors_on_#{collection_name}"

          define_method method_name do

            # Remove 'collection_name.xxx' attributes from errors
            targets = []
            errors.each do |attribute, message|
              targets << attribute if attribute.to_s =~ /^#{collection_name}\./
            end
            targets.each{|k| errors.delete(k) }

            # Add original errors
            index = 0
            send(collection_name).each do |r|
              next if options[:ignore_marked_for_destruction] && r.marked_for_destruction?
              index += 1
              next if r.errors.empty?

              r.errors.full_messages.each do |full_message|
                errors.add(:base, generate_error_message_for_collection_element(collection_name, index, full_message))
              end
            end
          end

          after_validation method_name
        end
      end
    end
  end
end
