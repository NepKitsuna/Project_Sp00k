extends Panel

var buttonSize = Vector2(80,20)

func _ready():
	#Sets the Panel Size
	#DisplayServer.window_set_size(Vector2i(1280,720))
	set_size(DisplayServer.window_get_size())
	
	#Creates the button
	var playButton = Button.new()
	var optionsButton = Button.new()
	var creditsButton = Button.new()
	var quitButton = Button.new()
	
	#Sets the button's position
	playButton.set_position(Vector2(0,20))
	playButton.set_size(buttonSize)
	
	
	#optionsButton.set_position(playButton.position * Vector2(1,3))
	optionsButton.set_size(buttonSize)
	optionsButton.offset_top = playButton.position.y + buttonSize.y * 2
	
	#creditsButton.set_position(playButton.position * Vector2(1,5))
	creditsButton.set_size(buttonSize)
	creditsButton.offset_top = optionsButton.position.y + buttonSize.y * 2
	
	#quitButton.set_position(playButton.position)
	quitButton.set_size(buttonSize)
	quitButton.offset_top = creditsButton.position.y + buttonSize.y * 2
	
	
	#Populate the buttons with text and their function
	playButton.text = "Play"
	#playButton.pressed.connect(self._playButton_pressed())
	
	optionsButton.text = "Options"
	
	creditsButton.text = "Credits"
	
	quitButton.text = "Quit"
	quitButton.pressed.connect(self._quitButton_pressed)
	
		
	
	#Enables/Disables the playButton
	#playButton.show()
	#playButton.hide()
	
	add_child(playButton)
	add_child(optionsButton)
	add_child(creditsButton)
	add_child(quitButton)
	pass



#Add Functionality
func _quitButton_pressed():
	get_tree().quit()
func _creditsButton_pressed():
	pass
func _optionsButton_pressed():
	pass
func _playButton_pressed():
	pass
