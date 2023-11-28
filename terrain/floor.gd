extends StaticBody2D

#Is a floor tile to be used in a tilemap. Has a collision shape and is layer and mask 1.
#Will change itself to a different region and frame of its sprite every time the MODE changes.
#Uses a random frame of the sprite to select one of the 4 sprites available for each floor terrain.

@onready var sprite2d: Sprite2D = $Sprite2D


func change_mode(new_terrain: int) -> void:
	sprite2d.region_rect = Rect2(0, 16 * new_terrain, 64, 192)
	sprite2d.frame = randi_range(0, 3)
