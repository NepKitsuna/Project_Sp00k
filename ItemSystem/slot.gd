extends PanelContainer

@onready var texture_rect = $MarginContainer/TextureRect
@onready var quantity_label = $QuantityLabel

func setSlot(slotData: SlotData) -> void:
	var itemData = slotData.item_data
	texture_rect.texture = itemData.texture
	tooltip_text= "%s\n%s" % [itemData.name, itemData.description]
	
	if slotData.quantity > 1:
		quantity_label.text = "x%s" % [slotData.quantity]
		quantity_label.show()
