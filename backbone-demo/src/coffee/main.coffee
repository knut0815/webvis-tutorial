# -------------------

$ ->
	app = new App()

# -------------------

class App extends Backbone.Router
	views: {}
	models: {}

	routes:
		'*path': 'urlChanged'

	initialize: ()->

		# initialize data models
		@models.currentUser = new User()

		# initialize views
		@views.userView = new UserView(
			model: @models.currentUser
			el: $("#user-info")
		)

		# start app and read first location hash
		Backbone.history.start()

	urlChanged: (path) =>
		console.log "page changed", path
		@models.currentUser.set "name", path


# -------------------


class User extends Backbone.Model
	defaults:
		name: "no_name"

	initialize: (@name) ->
		# constructor
		console.log "new user created: ", @get "name"


# -------------------


class UserView extends Backbone.View

	initialize: (options) ->
		# constructor

		# render view when model changes
		@model.on "change", @render

		# render now
		@render()

	render: ()=>
		console.log "render", @model.get "name"

		# draw
		@$el.html "Current user name: #{@model.get "name"}"
