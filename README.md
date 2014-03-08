PresenterRails
=====================

PresenterRails helps you expose view models to your views with ease.

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

PresenterRails works very well with [singular_resource](https://github.com/ElMassimo/singular_resource).

## Background
PresenterRails attempts to simplify the exposure of variables to the views. It doesn't really care
about what you are exposing, although it's specially useful to implement [two-step views](http://martinfowler.com/eaaCatalog/twoStepView.html) while using
[draper](https://github.com/drapergem/draper) together with [singular_resource](https://github.com/ElMassimo/singular_resource).

### How it works

When you provide a block, it defines a `"#{name}_presenter"` private method in your controller the same way you would do manually.

After that, it creates helper methods for your views, each method calls its `"#{name}_presenter"` counterpart in the controller.

#### Memoization
Each presenter method is memoized, so the method is called only once and your views get the same instance every time.

#### Corolary
Since the helper methods defined are only available for the view, you can define methods with the same name in your controller :smiley:.
