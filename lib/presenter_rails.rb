require "presenter_rails/version"
require "active_support/all"

module PresenterRails
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
      if instance_variable_defined?(ivar)
        instance_variable_get(ivar)
      else
        instance_variable_set(ivar, instance_exec(&block))
      end
    }

    helper Module.new {
      define_method(name) { controller.send(presenter_method) }
    }
  end

  # Internal: Name of the presenter method as defined in the controller.
  def self.method_name_for(name)
    "#{ name }_presenter"
  end

  # Internal: Name of the instance variable used to memoize a presenter method.
  def self.ivar_for(name)
    "@_presenter_#{ name.to_s.gsub("?", "_query").gsub("!", "_bang") }"
  end

  ActiveSupport.on_load :action_controller do
    extend PresenterRails
  end

  ActiveSupport.on_load :action_mailer do
    extend PresenterRails
  end
end
