extends RayCast2D

signal player_exited_sticky

@export var my_mode: int = 0

var player: CharacterBody2D
var got_player: bool = false
var just_got_player: bool = false
var just_lost_player: bool = false

@onready var sprite2d: Sprite2D = $Sprite2D


func _ready():
	visible = false


func _process(_delta):
	if visible:
		if is_colliding():
			visible = true
			if !got_player:
				player = get_collider()
				got_player = true
				just_got_player = true
			else:
				global_rotation = get_angle_to(player.global_position + Vector2(0, 6)) + PI / 2
				scale.y = player.global_position.distance_to(global_position) / 16
				scale.y = clamp(scale.y, 0.1, 1.25)
				scale.x = scale.y
			player.sticky = true
			if just_got_player:
				just_got_player = false
		else:
			if got_player:
				got_player = false
				just_lost_player = true
				player.sticky = false
			if just_lost_player:
				just_lost_player = false
				player.sticky = false
				emit_signal("player_exited_sticky")
				visible = false
