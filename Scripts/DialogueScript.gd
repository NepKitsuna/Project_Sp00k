extends RichTextLabel

var drawTextStart = 1
var drawSpeed = 2
var charLimit = 2000

func _ready():
	pass

func _DisplayText():
	if drawTextStart < charLimit:
		drawTextStart += drawSpeed
		self.visible_characters = drawTextStart
		pass
		
func _process(_delta):
	_DisplayText()
	pass
	
func setRoomText(newText):
	self.text = str(newText)
	pass
