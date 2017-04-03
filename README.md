Presenter [![Gem Version](https://badge.fury.io/rb/presenter_rails.svg)](http://badge.fury.io/rb/presenter_rails) [![Build Status](https://travis-ci.org/ElMassimo/presenter_rails.svg?branch=master)](https://travis-ci.org/ElMassimo/presenter_rails) [![Coverage Status](https://coveralls.io/repos/github/ElMassimo/presenter_rails/badge.svg?branch=master)](https://coveralls.io/github/ElMassimo/presenter_rails?branch=master) [![Inline docs](http://inch-ci.org/github/ElMassimo/presenter_rails.svg)](http://inch-ci.org/github/ElMassimo/presenter_rails) [![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/ElMassimo/presenter_rails/blob/master/LICENSE.txt)
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
[draper](https://github.com/drapergem/draper) in combination with [resourcerer](https://github.com/ElMassimo/resourcerer).

### How it works

When you provide a block, it defines a `"#{name}_presenter"` private method in your controller.

After that, it creates a helper method for your views, which calls the `"#{name}_presenter"` counterpart in the controller.

#### Memoization
Each presenter method is memoized, so the method is called only once and your views get the same instance every time. The block is evaluated only if the method is called.

#### Corolary
Since the helper methods defined are only available for the view, you can define methods with the same name in your controller :smiley:.

License
--------

    Copyright (c) 2014 Máximo Mussini

    MIT License

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


Credits
--------
Presenter was crafted to use in combination with [resourcerer](https://github.com/ElMassimo/resourcerer) and
[draper](https://github.com/drapergem/draper).
