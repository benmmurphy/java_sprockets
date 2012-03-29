$(() ->
  Todo = Backbone.Model.extend
    defaults:
      content: "empty todo..."
      done: false


    initialize: () ->
      if !@get("content")
        @set(content: this.defaults.content)

    toggle: () ->
      @save(done: !this.get("done"))


    clear: () ->
      @destroy()

  TodoList = Backbone.Collection.extend
    model: Todo

    localStorage: new Store("todos-backbone")

    done: () ->
      @filter((todo) => todo.get("done"))

    remaining: () ->
      @without.apply(@, @done())

    nextOrder: () ->
      if (@length == 0) 
        1
      else
        @last().get('order') + 1
    
    comparator: (todo) ->
      todo.get('order')


  Todos = new TodoList

  TodoView = Backbone.View.extend
    tagName: "li"
    
    template: JST['templates/items_template']

    events: 
      "click .check" : "toggleDone"
      "dblclick label.todo-content" : "edit"
      "click span.todo-destroy"  : "clear"
      "keypress .todo-input" : "updateOnEnter"
      "blur .todo-input" : "close"

    initialize: () ->
      _.bindAll(@, 'render', 'close', 'remove')
      @model.bind('change', @render)
      @model.bind('destroy', @remove)

    render: () ->
      console.log(typeof(@model.toJSON()))
      $(@el).html(@template(@model.toJSON()))
      @input = this.$('.todo-input')
      @

    toggleDone: () ->
      @model.toggle()

    edit: () ->
      $(@el).addClass("editing")
      @input.focus()

    close: () ->
      @model.save(content: @input.val())
      @el.removeClass("editing")

    updateOnEnter: (e) ->
      if e.keyCode == 13
        @close()

    clear: () ->
      @model.clear()

  AppView = Backbone.View.extend


    statsTemplate: JST['templates/stats_template']
    mainTemplate: JST['templates/main']
    tagName: 'div',

    events:
      "keypress #new-todo" : "createOnEnter"
      "keyup #new-todo" : "showTooltip"
      "click .todo-clear a" : "clearCompleted"
      "click .mark-all-done" : "toggleAllComplete"

    initialize: () ->
      @$el.html(@mainTemplate())
      document.body.appendChild(@$el[0]) 

      _.bindAll(@, 'addOne', 'addAll', 'render', 'toggleAllComplete')
      @input = this.$("#new-todo")
      @allCheckbox = this.$(".mark-all-done")[0]
      Todos.bind('add', this.addOne)
      Todos.bind('reset', this.addAll)
      Todos.bind('all', this.render)

      Todos.fetch()

     render: () ->
        done = Todos.done().length
        remaining = Todos.remaining().length

        content = @statsTemplate({
          total:      Todos.length,
          done:       done,
          remaining:  remaining
        })
        this.$('#todo-stats').html(content)

        @allCheckbox.checked = !remaining

      addOne: (todo) ->
        view = new TodoView({model: todo})
        this.$("#todo-list").append(view.render().el)

      addAll: () ->
        Todos.each(this.addOne)

      newAttributes: () ->
        content: this.input.val()
        order:   Todos.nextOrder()
        done:    false

      createOnEnter: (e) ->
        if (e.keyCode != 13) 
          return
        Todos.create(this.newAttributes())
        this.input.val('')

      clearCompleted: () ->
        _.each(Todos.done(), (todo) ->  todo.clear())
        false

      showTooltip: (e) ->
        tooltip = this.$(".ui-tooltip-top")
        val = this.input.val()
        tooltip.fadeOut()
        if (this.tooltipTimeout) 
          clearTimeout(this.tooltipTimeout)
        if (val == '' || val == this.input.attr('placeholder')) 
          return
        show = () ->  tooltip.show().fadeIn()
        this.tooltipTimeout = _.delay(show, 1000)

      toggleAllComplete: () ->
        done = this.allCheckbox.checked
        Todos.each((todo) -> todo.save({'done': done}) )
     
  App = new AppView
) 
