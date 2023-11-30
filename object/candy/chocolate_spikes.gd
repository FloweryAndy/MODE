extends Area2D

@export var my_mode: int = 0

var can_act = true
var expanded = false

@onready var sprite2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape2d: CollisionShape2D = $CollisionShape2D
@onready var shape_cast2d: ShapeCast2D = $ShapeCast2D


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if shape_cast2d.is_colliding() and can_act and !expanded:
		can_act = false
		animation_player.play("expand")
		await animation_player.animation_finished
		can_act = true
	elif !shape_cast2d.is_colliding() and can_act and expanded:
		can_act = false
		animation_player.play_backwards("expand")
		await animation_player.animation_finished
		can_act = true


func change_mode(new_mode: int) -> void:
	if new_mode == my_mode:
		visible = true
		collision_shape2d.disabled = false
	else:
		visible = false
		collision_shape2d.disabled = true
