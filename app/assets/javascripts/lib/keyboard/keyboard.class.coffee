class window.FARMA.Keyboard

  constructor: (id) ->
    @screen = new window.FARMA.Screen()
    @hbs = new window.FARMA.Hbs()

    Handlebars.registerHelper 'log', (context) ->
      console.log context

    # render
    $('#keyboard-panel-' + id).render(@hbs.render('keyboard'), {
        id: id
        keys: [
          { key: 7, value: 7, type: "key" },
          { key: 8, value: 8, type: "key" },
          { key: 9, value: 9, type: "key" },
          { key: "÷", value: "\\over", type: "operator" },
          { key: "", value: "", type: "special mdi mdi-sigma" },
          { key: 4, value: 4, type: "key" },
          { key: 5, value: 5, type: "key" },
          { key: 6, value: 6, type: "key" },
          { key: "x", value: "*", type: "operator" },
          { key: "", value: "", type: "special mdi mdi-function" },
          { key: 1, value: 1, type: "key" },
          { key: 2, value: 2, type: "key" },
          { key: 3, value: 3, type: "key" },
          { key: "-", value: "-", type: "operator" },
          { key: "", value: "", type: "special mdi mdi-flask-outline" },
          { key: ".", value: ".", type: "key" },
          { key: 0, value: 0, type: "key" },
          { key: "=", value: "=", type: "key" }
          { key: "+", value: "+", type: "operator" }
          { key: "", value: "\\left[\\begin{matrix}\\end{matrix}\\right]", type: "special mdi mdi-matrix" },
        ]
        specialKeys: [
          { key: "√", value: "\\sqrt{}", type: "key" },
          { key: "(", value: "{", type: "key" },
          { key: ")", value: "}", type: "key" },
          { key: "", value: "", type: "eval mdi mdi-desktop-mac tooltipped", options: "data-tooltip=Renderizar TeX data-delay=50 data-position=bottom" },
          # { key: "", value: "check", type: "eval mdi mdi-account-check" }
          # { key: "", value: "\\left[\\begin{matrix}\\end{matrix}\\right]", type: "operator mdi mdi-matrix" },
          # { key: "&", value: "&", type: "key" },
          # { key: "𝑥²", value: "^2", type: "key" },
          # { key: "%", value: "*100", type: "key" },
          # { key: "", value: "\\\\", type: "operator mdi mdi-keyboard-return" }
        ]
      })

    # Apply functionality
    @onSubmit(id)

    if !$("#question-" + id + "-show").hasClass("keyboard-active")
      @clickHandler(id)
      # @hotKeyHandler(id)
      @checkAnswer(id)
      $("#question-" + id + "-show").addClass("keyboard-active")
    console.log $(".tooltipped")
    $('.tooltipped').tooltip delay: 50

  clickHandler: (id) ->
    self = @screen
    $(document).on 'click', "#keyboard-#{id} .key", (e) ->
      if $(this).attr('data-value') != 'C'
        self.addToJax($(this).text(), $(this).attr("data-value"), id)
      else
        self.cleanScreen(id)

    $(document).on 'click', "#diyBtn", ->
      console.log 'diy'
      $('.screen').toggle()

    $('form').on 'submit', ->
      # $('#keyboard-panel-' + id).hide()
      $('.box-response').show()

    hbs = @hbs
    $(document).on 'click', ".mdi-matrix", ->

      $('#keyboard-' + id).find("#more").render(hbs.render('formulas'), {
        keys: [
          { key: "&", value: "&", type: "key" },
          { key: "", value: "\\\\", type: "key mdi mdi-keyboard-return" },
          { key: "", value: 9, type: "key" },
          { key: "÷", value: "\\over", type: "key" }
        ]
      })
      $('#keyboard-' + id).find("#more").show("slide", {direction: "left"}, 5000)

  onSubmit: (id) ->
    $(document).on 'submit', "#keyboard-form-#{id}", ->
      $("#keyboard-#{id}").hide()
      $("#question-#{id}-show .box-response").show()

  hotKeyHandler: (id) ->
    self = @screen
    $(document).on 'keypress', (e) ->
      switch e.key
        when 's' then self.addToJax("s", "\\sqrt{}", id)
        when 'o' then self.addToJax("o", "\\over", id)
        when 'm' then self.addToJax("m", "\\left[\\begin{matrix}\\end{matrix}\\right]", id)
        when 'n' then self.addToJax("n", "\\\\", id)
        when 'e' then self.addToJax("e", "&", id)
        when 'C' then self.cleanScreen(id)
        else self.addToJax(e.key, id)

  checkAnswer: (where) ->
    $("#response-form-#{where}").bind 'ajax:complete', ->
    # $(document).on 'submit', "#response-form-#{where}", ->
      if $("#test-response-#{where} .box-response").hasClass('invalid')
        $("#keyboard-#{where} .jax").addClass('invalid-expression')
        $("#keyboard-#{where} .jax").removeClass('valid-expression')
      if $("#test-response-#{where} .box-response").hasClass('valid')
        $("#keyboard-#{where} .jax").addClass('valid-expression')
        $("#keyboard-#{where} .jax").removeClass('invalid-expression')
