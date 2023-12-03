extends StaticBody2D

@export var my_mode: int = 0
@export var finished_growing: bool = false
@onready var overgrown_grass_scene = preload("res://object/grassy/overgrown_grass.tscn")
@onready var sprite2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var start_growing_timer: Timer = $StartGrowingTimer
@onready var collision_shape2d: CollisionShape2D = $CollisionShape2D
@onready var raycast_2d: RayCast2D = $RayCast2D


func _ready():
	change_mode(0)
	start_growing_timer.timeout.connect(_on_start_growing_timer_timeout)
	animation_player.animation_finished.connect(_on_finished_growing)


func change_mode(new_mode: int) -> void:
	if new_mode == my_mode:
		visible = true
		collision_shape2d.disabled = false
		if !finished_growing:
			if start_growing_timer.paused:
				start_growing_timer.paused = false
			else:
				start_growing_timer.start()
	else:
		visible = false
		collision_shape2d.disabled = true
		animation_player.pause()
		start_growing_timer.paused = true


func breakable() -> void:
	queue_free()


func _on_start_growing_timer_timeout():
	if animation_player.current_animation_position > 0:
		animation_player.play()
	else:
		animation_player.play("Grow")


func _on_finished_growing(_anim):
	finished_growing = true
	if !raycast_2d.is_colliding():
		var new_grass = overgrown_grass_scene.instantiate()
		add_child(new_grass)
		new_grass.global_position = global_position
		new_grass.global_position.y -= 16
