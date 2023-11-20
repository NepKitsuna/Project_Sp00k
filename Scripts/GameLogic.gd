extends Node

#Creates an array for storing past rooms (With a memory limit)
var roomHistory = []

func _ready():
	
	if roomHistory.size() == 0:
		CreateRoom(0, "This is test data")
		$"MarginContainer/Textbox/Text Overlay/Dialogue".setRoomText(roomHistory[0].roomDialogue)
		pass
	
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
	newRoom.scpID = scpID
	newRoom.roomDialogue = roomDialogue
	
	#check the array for the amount of rooms
	var latestRoom = roomHistory.size()
	newRoom.roomID = latestRoom
	
	roomHistory.append(newRoom)
	
	pass


func _on_top_left_button_pressed():
	pass # Replace with function body.


func _on_top_right_button_pressed():
	pass # Replace with function body.


func _on_bottom_right_button_pressed():
	pass # Replace with function body.


func _on_bottom_left_button_pressed():
	pass # Replace with function body.
