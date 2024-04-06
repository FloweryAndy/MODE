extends Node
@export var is_floor: bool = false
@onready var sprite2d: Sprite2D = $".."


func _ready():
	if is_floor:
		sprite2d.frame = randi_range(0, 3)


func change_mode(new_terrain: int) -> void:
	sprite2d.region_rect = Rect2(sprite2d.region_rect.position.x, 16 * new_terrain, 64 if is_floor else 16, 16)
	if is_floor:
		sprite2d.frame = randi_range(0, 3)
