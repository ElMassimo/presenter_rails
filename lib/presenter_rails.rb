require "presenter_rails/version"
require "active_support/all"

module PresenterRails
  autoload :Controller, "presenter_rails/controller"

  # Internal: Name of the presenter method as defined in the controller.
  def self.method_name_for(name)
    "#{ name }_presenter"
  end

  # Internal: Name of the instance variable used to memoize a presenter method.
  def self.ivar_for(name)
    "@_presenter_#{ name.to_s.gsub("?", "_query").gsub("!", "_bang") }"
  end

  ActiveSupport.on_load :action_controller do
    extend Controller
  end

  ActiveSupport.on_load :action_mailer do
    extend Controller
  end
end
