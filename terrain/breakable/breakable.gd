extends StaticBody2D

@export var my_mode: int = 0
@onready var sprite2d: Sprite2D = $Sprite2D


func change_mode(new_mode: int):
	var my_x = 128 if new_mode == my_mode else 144
	sprite2d.region_rect = Rect2(my_x, new_mode * 16, 16, 16)
