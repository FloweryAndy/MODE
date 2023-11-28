extends ParallaxBackground

#Parallaxes a background image which can change in terrain type.

@onready var sprite2d: Sprite2D = $Sprite2D


func change_mode(new_terrain: int) -> void:
	sprite2d.region_rect = Rect2(0, 720 * new_terrain, 2560, 720)
