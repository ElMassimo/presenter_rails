require "spec_helper"
require "support/rails_app"
require "rspec/rails"
require "action_mailer"

class BirdsMailer < ActionMailer::Base
  present(:bird) { OpenStruct.new(name: @name) }

  def hello_bird(name:)
    @name = name
    mail { |format| format.text { render plain: bird_presenter.name } }
  end
end

RSpec.describe BirdsMailer, type: :mailer do
  Given(:name) { "pidgeon" }

  context "with keyword arguments" do
    When(:mail) { BirdsMailer.hello_bird(name: name) }
    Then { mail.body.to_s == name }
  end
end
