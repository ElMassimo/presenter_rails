module PresenterRails
  module Presenter
    extend ActiveSupport::Concern
    include SimpleMemoizer

    module ClassMethods
      def present(*methods)
        methods.flatten!
        presenter_methods = *Presenter.presenter_method_names(methods)
        enforce_private_methods!(presenter_methods)

        presenter_method *methods
        memoize presenter_methods
      end

      def presenter_method(*method_names)
        presenters_module = Module.new do
          method_names.each do |name|
            module_eval <<-ruby_eval, __FILE__, __LINE__ + 1
              def #{name}
                controller.send('#{Presenter.presenter_method_name(name)}')
              end
            ruby_eval
          end
        end
        helper presenters_module
      end

      private

      def enforce_private_methods!(methods)
        method_set = methods.to_set
        if self.instance_methods.any? {|method| method_set.include?(method) }
          methods = method_set.select {|method| self.instance_method?(method) }
          Kernel.abort "[ERROR] You are exposing presenters by the `#{methods.join(', ')}` method, " \
            "which is either a non private method or overrides an existing method of the same name. " \
            "Consider using a different presenter name\n" \
            "#{caller.first}"
        end
      end
    end

    def self.presenter_method_names(method_names)
      method_names.map {|name| presenter_method_name(name) }
    end

    def self.presenter_method_name(name)
      "#{name}_presenter"
    end
  end
end
