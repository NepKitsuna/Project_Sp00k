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
	createSCP(426, "Safe", "Toaster", 1)
	
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
	var roomDialogue = "Connection terminated. I'm sorry to interrupt you, Elizabeth. If you still even remember that name. But I'm afraid you've been misinformed. You are not here to receive a gift. Nor, have you been called here by the individual you assume. Although, you have indeed been called. You have all been called here. Into a labyrinth of sounds and smells, misdirection and misfortune. A labyrinth with no exit, a maze with no prize. You don't even realize that you are trapped. Your lust of blood has driven you in endless circles. Chasing the cries of children in some unseen chamber. Always seeming so near, yet somehow out of reach. But, you will never find them, none of you will. This is where your story ends. And to you, my brave volunteer. Who somehow found this job listing not intended for you. Although, there was a way out planned for you, I have a feeling that's not what you want. I have a feeling that you are right where you want to be."
	var enterDialogue
	
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
	var enteredSCP = 0
	
	
	func sawSCP():
		seenSCP += 1
		pass
	#func getType():
		#return scpType
	func continueSCP():
		enteredSCP += 1
		pass
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
		426:
			#if _scp.seenSCP < 2:
				roomCurrent.roomDialogue = "Enter Toast Room?"
				roomCurrent.enterDialogue = "Toast Room!"
				roomCurrent.B1Text = "Continue"
				roomCurrent.B2Text = "Next"
				roomCurrent.B3Text = "..."
				roomCurrent.B4Text = "..."
			#else:
				#roomCurrent.roomDialogue = "You Died Lmao"
				#roomCurrent.B1Text = "..."
				#roomCurrent.B2Text = "..."
				#roomCurrent.B3Text = "..."
				#roomCurrent.B4Text = "..."
				#pass
		7754:
			roomCurrent.roomDialogue = "Oh no, it's " + _scp.scpEntry
			roomCurrent.B1Text = "Next"
			roomCurrent.B2Text = "..."
			roomCurrent.B3Text = "..."
			roomCurrent.B4Text = "..."
		529:
			var catSpeak = ["Out from the vents a cat scrambles forward, or at least what you assumed was a normal cat at first, but clearly there’s gotta be a catch. Before you is a gray tabby cat, however the back half of the cat doesn’t seem to exist. It’s cut straight down the middle with a black void where you’d see internals. It walks as if it still had the back half however, acting as if nothing was wrong. The tabby stretches in front of you showing you that even with its front arms bent the cat manages to keep itself standing as if it was using its hind legs. You approach the cat and it meows back in dismay but allows you to see it’s name tag. The little thing’s name is Josie. She demands attention like any other housecat would. Out of curiosity you attempt to pet the void part of the cat. She seems to like it for all of two seconds before hissing and swiping at you. You aren’t sure what changed or if that behavior is even all that strange for a cat. You’re hesitant on if it didn’t like the pet there or if it’s just temperamental. As quick as she arrived, she dashes back into the vent. You peer in after her, finding an empty wax container that at one point contained a small wheel of provolone cheese. No use in taking this, I don’t figure I’ll need discarded wax. That was a nice break and all considering what it could have been, but you should keep moving. Before making your way out you notice some scuffed up documents at the point where Josie was standing as if she placed them there for comfort.",
			"You hear a little bit of movement in the vents for the room. It terrifies you once again as you wonder what it could be this time… all before Josie lets out a simple mew of comfort through a grate. It’s nice to know it’s just a cat but the sudden noise causes you to jolt, to which freaks out Josie forcing her further into the vents.",
			"You notice a faint amount of breathing coming from the vents, you peer into the grate just enough to see Josie in there strained. It doesn’t make sense to you why until the cat turns around and attempts to swat dust from the vent behind it. At first you wonder what the cat knows that you don’t, but then you consider that those actions are ones a cat would do to cover up its ‘business’ in a cat box. Did… did the cat just go in the vent? There’s nothing there! It only now occurs to you, you have no clue how this cat could survive eating anything without a back half to remove it so the real question is where does it go? You stand back from the vent disgusted by the suggestion. Goodbye Josie, you comment to yourself as you leave.",
			"Another noise in the vents, all before you see the half-cat dart from your left to your right in a gray blur. The sudden movement makes you recoil so far you fall on your back. That damned cat!", 
			"Moving forward you find a freshly deceased mouse waiting in the walkway, you can’t help but wonder if this was Josie’s doing."]
			#Intelligently backtracks a step on Catometer to get the text on the Array before the current SCPSeen
			roomCurrent.roomDialogue = catSpeak[min(4,max(0,_scp.seenSCP-1))]
			roomCurrent.B1Text = "Next"
			roomCurrent.B2Text = "meow"
			roomCurrent.B3Text = "..."
			roomCurrent.B4Text = "..."
		055:
			roomCurrent.roomDialogue = "The front of the containment cell is a large steel door with the designation of “heavy containment” over two meters tall and about two meters wide to match. The sleek black automated locks seem to be electronic and as such in the blackout, no longer work to keep it shut. You twist the handle of the door, twisting it open to the cacophonous creek of a steel and cement crypt being unveiled. The room is about five meters wide and long, with a surrounding cage of bars around the cement walls, practically bordering it. Walking toward the center the subject of the room becomes apparent. Upon a small pedestal sits an object that is
Uh... I think it’s not round?

You were just looking at it but despite knowing you saw something, it doesn’t register long  enough to recall. You peek back and try to describe it.
What are we talking about?

The uh, room? Were you in a room? You’re in a hallway, that’s for certain. But for some reason you cannot remember where you were before that.

What was it we were asking again? You could have sworn there was some kind of question, but nothing comes to mind. You carry on none-the-less confused."

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
	if $CanvasLayer/MarginContainer/Buttons/bottomRight_Button.text == "Next":
		CreateRoom()
	else:
		pass # Replace with function body.

func _on_bottom_left_button_pressed():
	if $CanvasLayer/MarginContainer/Buttons/bottomLeft_Button.text == "Next":
		CreateRoom()
	else:
		pass # Replace with function body.
