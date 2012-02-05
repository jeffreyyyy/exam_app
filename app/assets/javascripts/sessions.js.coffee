window.Session = class Session
	constructor: ->
		@close_flash()
		
	close_flash: ->
		$('div.flash').click (e) ->
			$(this).remove()
			
jQuery ->
	new Session()