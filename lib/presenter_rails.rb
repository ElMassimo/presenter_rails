require 'presenter_rails/presenter'

ActiveSupport.on_load(:action_controller) do
  include PresenterRails::Presenter
end
