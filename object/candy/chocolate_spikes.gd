extends Area2D

var can_act = true
var expanded = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shape_cast2d: ShapeCast2D = $ShapeCast2D


func _ready() -> void:
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


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && expanded:
		body.hurt(10, global_position)
		set_deferred("monitoring", false)
