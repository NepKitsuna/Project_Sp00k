extends Node

#Class for holding SCP Data
class SCP:
	
	var scpID = 000
	var scpClass = "#NULL"
	var scpEntry = "Internal system error: Field undefined. Please contact system administrator. Internal system error: Field undefined. Please contact system administrator. InteRиαl Sуѕtєм ERяяσя: FïëlÐ ünÐëƒïnëÐ. ρĿєДšє ςόЛţДςţ šΫšţєΜMMMMMMMMMMMM^@#$@!^&&%**$*%^*%^%^"
	var weight = 0
	
	


#array holding General Room Dialogue (If no SCP is present)
var roomDia = ["This is test Data", "This is secondary test Data"]

#array holding Safe class SCPs
var safeSCPs = []

#array holding Dangerous class SCPs (i.e. Euclid, Keter, Archon, etc)
var dangerSCPs = []

func createSCP(scpID, scpClass, scpEntry, weight):
	var newSCP = SCP.new()
	
	newSCP.scpID = scpID
	newSCP.scpClass = scpClass
	newSCP.scpEntry = scpEntry
	newSCP.weight = weight
	
	if newSCP.scpClass != "Safe" || "safe":
		dangerSCPs.append(newSCP)
	else:
		safeSCPs.append(newSCP)
	
	pass
