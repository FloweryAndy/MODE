extends ParallaxBackground

#Parallaxes a background image which can change in terrain type.

@onready var sprite2d: Sprite2D = $ParallaxLayer/Sprite2D
@onready var parallax_layer: ParallaxLayer = $ParallaxLayer


func _ready():
	parallax_layer.motion_scale.x = sprite2d.texture.get_width() * sprite2d.scale.x / 1280
	parallax_layer.motion_mirroring.x = sprite2d.texture.get_width() * sprite2d.scale.x


func change_mode(new_terrain: int) -> void:
	sprite2d.region_rect = Rect2(0, 720 * new_terrain, 2560, 720)
