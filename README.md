Presenter
=====================

Presenter helps you expose view models to your views in a convenient way, while
still allowing you to define methods with the same name inside your controllers.

```ruby
   # app/controllers/person_controller.rb
   class PersonController < ApplicationController

      present :person do
        PersonPresenter.decorate(...)
      end
   end
```

```haml
   / app/views/people/show.html.haml
   .person
     .person-name= person.name
     .person-info= person.biography
```
If you don't provide a block for present, it will assume that you want to expose a `"#{name}_presenter"` method.
```ruby
   # app/controllers/person_controller.rb
   class PersonController < ApplicationController
      present :person, :people

      private

      def person_presenter
        PersonPresenter.decorate(...)
      end

      def people_presenter
        People.all
      end
   end
```

## Background
Presenter attempts to simplify the exposure of variables to the views. It doesn't really care
about what you are exposing, although it's specially useful to implement [two-step views](http://martinfowler.com/eaaCatalog/twoStepView.html) while using
[draper](https://github.com/drapergem/draper) in combination with [resourcerer](https://github.com/ElMassimo/resourcerer).

### How it works

When you provide a block, it defines a `"#{name}_presenter"` private method in your controller the same way you would do manually.

After that, it creates helper methods for your views, each method calls its `"#{name}_presenter"` counterpart in the controller.

#### Memoization
Each presenter method is memoized, so the method is called only once and your views get the same instance every time.

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
