Presenter
=====================

Presenter helps you expose view models to your views with a declarative approach.

```ruby
   # app/controllers/person_controller.rb
   class PersonController < ApplicationController
      present :person
      
      private
        def person_presenter
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

Presenter works very well with [singular_resource](https://github.com/ElMassimo/singular_resource).
