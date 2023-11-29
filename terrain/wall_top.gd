extends StaticBody2D

@onready var sprite2d: Sprite2D = $Sprite2D


func change_mode(new_terrain: int) -> void:
	sprite2d.region_rect = Rect2(96, 16 * new_terrain, 16, 16)
