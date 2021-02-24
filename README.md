Presenter [![Gem Version](https://badge.fury.io/rb/presenter_rails.svg)](https://rubygems.org/gems/presenter_rails) [![Build Status](https://github.com/ElMassimo/presenter_rails/workflows/build/badge.svg)](https://github.com/ElMassimo/presenter_rails/actions) [![Test Coverage](https://codeclimate.com/github/ElMassimo/presenter_rails/badges/coverage.svg)](https://codeclimate.com/github/ElMassimo/presenter_rails) [![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/ElMassimo/presenter_rails/blob/master/LICENSE.txt)
=====================

Presenter helps you expose view models to your views in a convenient way, while
still allowing you to define methods with the same name inside your controllers.

```ruby
 # app/controllers/people_controller.rb
 class PeopleController < ApplicationController

    present(:person) {
      PersonDecorator.decorate(person)
    }

    ...

    def person
      People.find(params[:id])
    end
 end
```

```haml
 / app/views/people/show.html.haml
 .person
   .person-name= person.name
   .person-info= person.biography
```

The method is also available in the controller, with a `_presenter` suffix:
```ruby
 # app/controllers/people_controller.rb
 class PeopleController < ApplicationController

    present(:person) {
      PersonDecorator.decorate(person)
    }

    def update
      person.update(attrs)
      redirect_to person_presenter.path, notice: "Successfully updated."
    end

    ...

 end
```

## Background
Presenter attempts to simplify the exposure of variables to the views. It doesn't really care
about what you are exposing, although it's specially useful to implement [two-step views](http://martinfowler.com/eaaCatalog/twoStepView.html) while using
[view models](https://github.com/drapergem/draper) in combination with [resourcerer](https://github.com/ElMassimo/resourcerer).

### How it works

When you provide a block, it defines a `"#{name}_presenter"` private method in your controller.

After that, it creates a helper method for your views, which calls the `"#{name}_presenter"` counterpart in the controller.

#### Memoization
Each presenter method is memoized, so the method is called only once and your views get the same instance every time. The block is evaluated only if the method is called.

#### Corolary
Since the helper methods defined are only available for the view, you can define methods with the same name in your controller :smiley:

Credits
--------
Presenter was crafted to use in combination with [resourcerer](https://github.com/ElMassimo/resourcerer).
