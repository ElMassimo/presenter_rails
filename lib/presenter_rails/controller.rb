module PresenterRails
  module Controller
    # Public: Defines a method and makes it available to the view context
    # under the specified name as a memoized variable.
    #
    # name  - The name of the method as called from the view context.
    # block - Executed once if (and only if) the method is called.
    #
    # Returns nothing.
    def present(name, &block)
      presenter_method = PresenterRails.method_name_for(name)
      ivar = PresenterRails.ivar_for(name)

      private define_method(presenter_method) {
        unless instance_variable_defined?(ivar)
          instance_variable_set(ivar, instance_exec(&block))
        end
        instance_variable_get(ivar)
      }

      helper Module.new {
        define_method(name) { controller.send(presenter_method) }
      }
    end
  end
end
