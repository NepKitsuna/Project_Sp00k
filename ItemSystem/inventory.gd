extends PanelContainer

const Slot = preload("res://ItemSystem/slot.tscn")

@onready var itemGrid: GridContainer = $MarginContainer/GridContainer

#temp func for testing purposes
func _ready() -> void:
	var invData = preload("res://test_inv.tres")
	populateInventory(invData.slotGrid)

func populateInventory(slotGrid: Array[SlotData]) -> void:
	for child in itemGrid.get_children():
		child.queue_free()
	
	for slotdata in slotGrid:
		var slot = Slot.instantiate()
		itemGrid.add_child(slot)
		
		if slotdata:
			slot.setSlot(slotdata)
