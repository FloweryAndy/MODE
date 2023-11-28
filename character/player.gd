extends CharacterBody2D

@export var speed = 100
@export var jump = 300
@export var gravity = 500
@onready var animation_player = $AnimationPlayer
@onready var sprite2d = $Sprite2D


func _ready() -> void:
	pass
	#animation_player.play("idle")


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	var direction = Input.get_axis("left", "right")
	if direction:
		sprite2d.flip_h = direction < 0
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump

	move_and_slide()
