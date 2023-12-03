extends Area2D

@export var my_mode: int = 0

var can_act = true
var expanded = false

@onready var sprite2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape2d: CollisionShape2D = $CollisionShape2D
@onready var shape_cast2d: ShapeCast2D = $ShapeCast2D


func _ready() -> void:
	visible = false
	set_deferred("monitoring", false)
	body_entered.connect(_on_body_entered)


func _process(_delta: float) -> void:
	if visible:
		if shape_cast2d.is_colliding() and can_act and !expanded:
			await get_tree().create_timer(0.5).timeout
			can_act = false
			animation_player.play("expand")
			await animation_player.animation_finished
			if visible:
				set_deferred("monitoring", true)
			expanded = true
			can_act = true
		elif !shape_cast2d.is_colliding() and can_act and expanded:
			await get_tree().create_timer(0.5).timeout
			can_act = false
			animation_player.play_backwards("expand")
			set_deferred("monitoring", false)
			await animation_player.animation_finished
			expanded = false
			can_act = true


func change_mode(new_mode: int) -> void:
	if new_mode == my_mode:
		visible = true
	else:
		set_deferred("monitoring", false)
		visible = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.hurt(10, sprite2d.global_position)
		set_deferred("monitoring", false)
