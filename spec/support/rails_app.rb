require "action_controller"
require "rails"

def request_params(params)
  return params if Rails::VERSION::MAJOR < 5
  { params: params }
end

module Rails
  class App
    def env_config
      {}
    end

    def routes
      @routes ||= ActionDispatch::Routing::RouteSet.new.tap do |routes|
        routes.draw do
          resources :birds
        end
      end
    end
  end

  def self.root
    ''
  end

  def self.application
    @app ||= App.new
  end
end

class ApplicationController < ActionController::Base
  include Rails.application.routes.url_helpers
end

class BirdsController < ApplicationController
 def index
   head :ok
 end
end
