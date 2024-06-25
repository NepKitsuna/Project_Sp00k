extends Node



var roomText
var B1HText 
var B2HText 
var B3HText
var B4HText

var roomCurrent
var emptySeen = 0
var totalVisited = 0
var emptyWeight = 4
var safeVisited = 0
var scpChance = 0

func _ready():
	
	#Example
	#scpControl.createSCP(000, "Class", "Entry", 0 )
	createSCP(7754, "Keter", "A thing that kills you", 1 )
	createSCP(529, "Safe", "Josie, the Half Cat", 1)
	createSCP(055, "Safe", "Antimeme", 1)
	
	roomText = $"CanvasLayer/MarginContainer/Textbox/Text Overlay/Dialogue"
	B1HText = $CanvasLayer/MarginContainer/Buttons/bottomLeft_Button
	B2HText = $CanvasLayer/MarginContainer/Buttons/bottomRight_Button
	B3HText = $CanvasLayer/MarginContainer/Buttons/topLeft_Button
	B4HText = $CanvasLayer/MarginContainer/Buttons/topRight_Button
	
	CreateRoom()
	roomText.setRoomText(roomCurrent.roomDialogue)
	B1HText.set_text(roomCurrent.B1Text)
	B2HText.set_text(roomCurrent.B2Text)
	B3HText.set_text(roomCurrent.B3Text)
	B4HText.set_text(roomCurrent.B4Text)
	
	pass

func _process(delta):
	
	#Debuging Quick Quit Key
	if Input.is_key_pressed(KEY_B):
		get_tree().quit()
	
	if !roomCurrent.rSCP:
		#do nothing
		pass
	else:
		_roomLogic(roomCurrent.rSCP)
		pass
	
	roomText.setRoomText(roomCurrent.roomDialogue)
	B1HText.set_text(roomCurrent.B1Text)
	B2HText.set_text(roomCurrent.B2Text)
	B3HText.set_text(roomCurrent.B3Text)
	B4HText.set_text(roomCurrent.B4Text)
	return

class Room extends Node2D:
	
	#var roomType = ""
	var rSCP
	var B1Text = "Next"
	var B2Text = "..."
	var B3Text = "..."
	var B4Text = "..."
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
	func getB1Text():
		return B1Text
	func getB2Text():
		return B2Text
	func getB3Text():
		return B3Text
	func getB4Text():
		return B4Text
	
	
#Class for holding SCP Data
class SCP:
	
	var scpID = 000
	#var scpType = "UNKNOWN" - Unsure what this was for. Seemingly Unused...
	var scpClass = "#NULL"
	var scpEntry = "Internal system error: Field undefined. Please contact system administrator. Internal system error: Field undefined. Please contact system administrator. InteRиαl Sуѕtєм ERяяσя: FïëlÐ ünÐëƒïnëÐ. ρĿєДšє ςόЛţДςţ šΫšţєΜMMMMMMMMMMMM^@#$@!^&&%**$*%^*%^%^"
	var weight = 0
	var seenSCP = 0
	
	
	func sawSCP():
		seenSCP += 1
		pass
	#func getType():
		#return scpType

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
	
	
	#var safeWeight = 0
	
	emptyWeight = max(1, totalVisited/max(1, emptySeen)) * 4
	#var safeWeight = max(1, roomsVisited/max(1, emptySeen))
	#Weight of highest SCP weight
	
	var tempSCP
	
	for i in scpPocket.size():
		if	scpPocket[i].weight > scpChance && scpPocket[i].scpClass == "Safe":
			scpChance = scpPocket[i].weight * max(1, emptySeen/max(1, totalVisited))
			tempSCP = scpPocket[i]
			safeVisited += 1
		#if the weights of the scps are the same, Flip a coin on who takes the spot.
		if tempSCP && scpPocket[i].weight == tempSCP.weight:
			if randi() %2 == 0:
				tempSCP = scpPocket[i]
		#pass
		
		
		
	if	tempSCP && emptyWeight < scpChance:
		newRoom.rSCP = tempSCP
		tempSCP.sawSCP()
		tempSCP.weight -= tempSCP.seenSCP
		#pass

	else:
		newRoom.roomDialogue = roomDia[randi_range(0, roomDia.size() - 1)]
		newRoom.B1Text = "Next"
		newRoom.B2Text = "..."
		newRoom.B3Text = "..."
		newRoom.B4Text = "..."
		emptySeen += 1
		
		for i in scpPocket.size():
			scpPocket[i].weight += 1
		
	totalVisited += 1
	roomCurrent = newRoom
	
	#pass


func _roomLogic(_scp):
	
	match _scp.scpID:
		000:
			roomCurrent.B1Text = "..."
			roomCurrent.B2Text = "..."
			roomCurrent.B3Text = "..."
			roomCurrent.B4Text = "..."
			return "you done fucked up"
		7754:
			roomCurrent.roomDialogue = "Oh no, it's " + _scp.scpEntry
			roomCurrent.B1Text = "Next"
			roomCurrent.B2Text = "..."
			roomCurrent.B3Text = "..."
			roomCurrent.B4Text = "..."
		529:
			var catSpeak = ["Oh shit a cat", "yoooo, Same cat!!", "There be the cat again!!", "I'm getting tired of the cat", "Oh shit, no cat here :("]
			#crappy downsizing to keep it from breaking scope.
			roomCurrent.roomDialogue = catSpeak[min(4,max(0,_scp.seenSCP-1))]
			roomCurrent.B1Text = "Next"
			roomCurrent.B2Text = "meow"
			roomCurrent.B3Text = "..."
			roomCurrent.B4Text = "..."
		055:
			roomCurrent.roomDialogue = "I forgor"
			roomCurrent.B1Text = "Next"
			roomCurrent.B2Text = "..."
			roomCurrent.B3Text = "..."
			roomCurrent.B4Text = "..."
	
	
	pass

func _on_top_left_button_pressed():
	pass # Replace with function body.


func _on_top_right_button_pressed():
	pass # Replace with function body.


func _on_bottom_right_button_pressed():
	pass # Replace with function body.


func _on_bottom_left_button_pressed():
	if $CanvasLayer/MarginContainer/Buttons/bottomLeft_Button.text == "Next":
	
		CreateRoom()
		
	
	else:
		pass # Replace with function body.
