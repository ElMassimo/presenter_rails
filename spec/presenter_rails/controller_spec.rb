require "spec_helper"
require "rspec/rails"

RSpec.describe PresenterRails::Controller do
  class Thing; end
  class DifferentThing; end

  class ViewContext
    attr_reader :controller

    def initialize(controller)
      @controller = controller
    end
  end

  class BaseController
    extend PresenterRails::Controller

    def self.helper(helper_module)
      @helper_modules ||= []
      @helper_modules << helper_module
    end

    def self.helper_modules
      @helper_modules
    end

    def view_context
      self.class.helper_modules.inject(ViewContext.new(self)) { |view_context, helper_module|
        view_context.extend(helper_module)
      }
    end
  end

  Given(:controller_class) { Class.new(BaseController) }
  Given(:controller) { controller_class.new }
  Given(:view_context) { controller.view_context }
  Given(:helper_modules) { controller_class.helper_modules }

  delegate :present, to: :controller_class

  context "present" do
    Given {
      expect(controller).to receive(:thing).once.and_return(Thing.new)
      expect(controller).to receive(:different_thing).once.and_return(DifferentThing.new)
      expect(controller).to receive(:empty).once.and_return(nil)
    }

    Given {
      present(:thing) { thing }
      present(:another_thing) { different_thing }
      present(:empty?) { empty }
    }

    Then { controller.send(:thing_presenter).is_a?(Thing) }
    And  { controller.send(:another_thing_presenter).is_a?(DifferentThing) }
    And  { controller.send(:'empty?_presenter').nil? }

    And  { helper_modules.size == 3 }
    And  { helper_modules[0].instance_methods == [:thing] }
    And  { helper_modules[1].instance_methods == [:another_thing] }
    And  { helper_modules[2].instance_methods == [:empty?] }

    And  { view_context.thing.is_a?(Thing) }
    And  { view_context.another_thing.is_a?(DifferentThing) }
    And  { view_context.empty?.nil? }
  end
end
