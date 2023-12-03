extends ParallaxBackground

#Parallaxes a background image which can change in terrain type.

@onready var sprite2d: Sprite2D = $ParallaxLayer/Sprite2D
@onready var parallax_layer: ParallaxLayer = $ParallaxLayer


func change_mode(new_terrain: int) -> void:
	sprite2d.region_rect = Rect2(0, 720 * new_terrain, 2560, 720)
	if new_terrain == 3:
		parallax_layer.motion_scale.x = 1280.0
	else:
		parallax_layer.motion_scale.x = 0.5
