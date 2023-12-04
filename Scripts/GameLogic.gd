extends Node

#Creates an array for storing past rooms (With a memory limit)
var roomCurrent

func _ready():
	
	CreateRoom(000, "This is test data")
	$"MarginContainer/Textbox/Text Overlay/Dialogue".setRoomText(roomCurrent.roomDialogue)
	
	pass

class Room extends Node2D:
	
	var roomID = 0
	var scpID
	var roomDialogue = "default"
	
	func getRoomID():
		return roomID
	func getSCPID():
		return scpID
	func getRoomDialogue():
		return roomDialogue
	
	
#Function that creates a room, fills it with data and appends it to the array
func CreateRoom(scpID, roomDialogue):
	var newRoom = Room.new()
	
	#If there is one
	if scpID != 000:
		newRoom.scpID = scpID
		pass
	
	newRoom.roomDialogue = roomDialogue
	
	roomCurrent = newRoom
	
	pass


func _on_top_left_button_pressed():
	
	
	pass # Replace with function body.


func _on_top_right_button_pressed():
	pass # Replace with function body.


func _on_bottom_right_button_pressed():
	pass # Replace with function body.


func _on_bottom_left_button_pressed():
	pass # Replace with function body.
