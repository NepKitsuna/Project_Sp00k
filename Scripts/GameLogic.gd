extends Node

var roomText

var roomCurrent
var emptySeen = 0
var roomsVisited = 0

func _ready():
	
	#Example
	#scpControl.createSCP(000, "Class", "Entry", 0 )
	createSCP(7754, "Keter", "A thing that kills you", 1 )
	
	roomText = $"CanvasLayer/MarginContainer/Textbox/Text Overlay/Dialogue"
	
	CreateRoom()
	roomText.setRoomText(roomCurrent.roomDialogue)
	
	pass

func _process(delta):
	
	if !roomCurrent.rSCP:
		#do nothing
		pass
	else:
		_roomLogic(roomCurrent.rSCP)
		pass
	
	roomText.setRoomText(roomCurrent.roomDialogue)
	return

class Room extends Node2D:
	
	#var roomType = ""
	var rSCP
	var roomDialogue = "Connection terminated.
I'm sorry to interrupt you, Elizabeth.
If you still even remember that name.
But I'm afraid you've been misinformed.
You are not here to receive a gift.
Nor, have you been called here by the individual you assume.
Although, you have indeed been called.
You have all been called here.
Into a labyrinth of sounds and smells, misdirection and misfortune.
A labyrinth with no exit, a maze with no prize.
You don't even realize that you are trapped.
Your lust of blood has driven you in endless circles.
Chasing the cries of children in some unseen chamber.
Always seeming so near, yet somehow out of reach.
But, you will never find them, none of you will.
This is where your story ends.

And to you, my brave volunteer.
Who somehow found this job listing not intended for you.
Although, there was a way out planned for you,
I have a feeling that's not what you want.
I have a feeling that you are right where you want to be."
	
	func getRoomDialogue():
		return roomDialogue
	
	
#Class for holding SCP Data
class SCP:
	
	var scpID = 000
	var scpType = ""
	var scpClass = "#NULL"
	var scpEntry = "Internal system error: Field undefined. Please contact system administrator. Internal system error: Field undefined. Please contact system administrator. InteRиαl Sуѕtєм ERяяσя: FïëlÐ ünÐëƒïnëÐ. ρĿєДšє ςόЛţДςţ šΫšţєΜMMMMMMMMMMMM^@#$@!^&&%**$*%^*%^%^"
	var weight = 0
	var seenSCP = 0
	
	
	func sawSCP():
		seenSCP += 1
		pass
	func getType():
		return scpType

	#func roomLogic():
		
		#pass
#array holding General Room Dialogue (If no SCP is present)
var roomDia = ["This is test Data", "This is secondary test Data", "meep"]

#array that holds All SCPs
var scpPocket = []

func createSCP(scpID, scpClass, scpEntry, weight):
	var newSCP = SCP.new()
	
	newSCP.scpID = scpID
	newSCP.scpClass = scpClass
	newSCP.scpEntry = scpEntry
	newSCP.weight = weight

	scpPocket.append(newSCP)
	
	pass


#Function that creates a room, fills it with data and appends it to the array
func CreateRoom():
	var newRoom = Room.new()
	
	var emptyWeight = max(1, roomsVisited/max(1, emptySeen)) * 4
	#Weight of highest SCP weight
	var hNum = 0
	var tempSCP
	
	for i in scpPocket.size():
		if	scpPocket[i].weight > hNum:
			hNum = scpPocket[i].weight
			tempSCP = scpPocket[i]
		pass
		
	if	emptyWeight < hNum:
		newRoom.rSCP = tempSCP
		pass
	else:
		newRoom.roomDialogue = roomDia[randi_range(0, roomDia.size() - 1)]
	
	roomCurrent = newRoom
	
	pass


func _roomLogic(_scp):
	
	match _scp.scpID:
		000:
			return "you done fucked up"
		7754:
			roomCurrent.roomDialogue = "Oh no, it's " + _scp.scpEntry
		
			
	
	pass

func _on_top_left_button_pressed():
	CreateRoom()
	pass # Replace with function body.


func _on_top_right_button_pressed():
	CreateRoom()
	pass # Replace with function body.


func _on_bottom_right_button_pressed():
	CreateRoom()
	pass # Replace with function body.


func _on_bottom_left_button_pressed():
	CreateRoom()
	pass # Replace with function body.
