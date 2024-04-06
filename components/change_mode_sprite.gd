extends Node
@export var off_mode_x: int = 144
@export var on_mode_x: int = 128
@export var has_frames: bool = false
@onready var mode: Node = $"../../Mode"
@onready var sprite2d: Sprite2D = $".."


func change_mode(new_mode: int):
	var new_x = off_mode_x if new_mode == mode.my_mode else on_mode_x
	sprite2d.region_rect = Rect2(new_x, new_mode * 16, 64 if has_frames else 16, 16)
