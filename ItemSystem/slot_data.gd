extends Resource
class_name SlotData

const maxStackSize: int = 99

@export var item_data: ItemData
@export_range(1, maxStackSize) var quantity: int = 1
