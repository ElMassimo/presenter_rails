require 'pakiderm'

module PresenterRails
  module Presenter
    extend ActiveSupport::Concern

    included do
      extend Pakiderm
    end

    module ClassMethods

      # Can take a list of presenter methods, or a name and block for a presenter method
      def present(*methods, &block)
        presenter_methods = methods.map {|name| Presenter.method_name_for(name) }
        define_presenter_method!(presenter_methods, &block) if block_given?

        expose_presenter *methods
        memoize *presenter_methods, assignable: true
      end

      # Exposes a presenter method to the view for each provided name
      def expose_presenter(*method_names)
        presenters_module = Module.new do
          method_names.each do |name|
            module_eval <<-ruby_eval, __FILE__, __LINE__ + 1
              def #{name}
                controller.send('#{Presenter.method_name_for(name)}')
              end
            ruby_eval
          end
        end
        helper presenters_module
      end

      private

      # Defines a private presenter method that invokes the provided block
      def define_presenter_method!(methods, &block)
        if methods.size != 1
          Kernel.abort "[ERROR] You are providing a block for the `#{methods.join(', ')}` methods, " \
            "but you can only provide a block for a single presenter at a time.\n #{caller.second}"
        end
        presenter_method = methods.first
        define_method presenter_method, &block
        private presenter_method
      end
    end

    # Name of the presenter methods
    def self.method_name_for(name)
      "#{name}_presenter"
    end
  end
end
