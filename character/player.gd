extends CharacterBody2D

@export var speed = 100
@export var jump = 300
@export var gravity = 500
@export var health = 100
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite2d: Sprite2D = $Sprite2D
@onready var respawn_point: Marker2D = $"../Level/RespawnPoint"


func _ready() -> void:
	pass
	#animation_player.play("idle")


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	var direction = Input.get_axis("left", "right")
	if global_position.y > 360:
		respawn()
	if direction:
		sprite2d.flip_h = direction < 0
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump

	move_and_slide()


func change_mode(_new_mode: int) -> void:
	pass


func hurt(amount: int = 10, pos: Vector2 = global_position) -> void:
	global_position += -global_position.direction_to(pos) * amount * .8
	health -= amount
	print_debug("health" + str(health))
	if health <= 0:
		respawn()


func respawn() -> void:
	global_position = respawn_point.global_position


func checkpoint(area) -> void:
	respawn_point.global_position = area.global_position
