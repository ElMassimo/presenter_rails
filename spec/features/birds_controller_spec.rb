require "spec_helper"
require "support/rails_app"
require "rspec/rails"

RSpec.describe BirdsController, type: :controller do
  Given(:bird) { double(:bird) }

  context "present works well with the view context" do
    Given {
      class BirdsController
        present(:bird) { bird }
        present(:bird?) { bird_presenter.present? }
      end

      expect_any_instance_of(BirdsController).to receive(:bird).once.and_return(bird)
    }
    When { get :index }
    Then { controller.view_context.bird == bird }
    And  { controller.view_context.bird  == controller.send(:bird_presenter) }
    And  { controller.view_context.bird? == true }
  end
end
