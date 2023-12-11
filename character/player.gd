extends CharacterBody2D

enum Terrain {
	GRASSY, CANDY, ICY, TOWER, FACTORY, DARK, DESERT, DWARVEN, UNDERWATER, ANIMAL, HOME, MOON
}

@export var speed: int = 100
@export var jump: int = 300
@export var drag: float = 1.0
@export var gravity: int = 500
@export var health: int = 100
@export var current_mode: int = 0
@export var current_terrain: Terrain = Terrain.GRASSY
@export var sticky: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite2d: Sprite2D = $Sprite2D
@onready var respawn_point: Marker2D = $"../Level/RespawnPoint"
@onready var collision_shape2d: CollisionShape2D = $CollisionShape2D
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var light: DirectionalLight2D = $Light
@onready var darklight: DirectionalLight2D = $Darklight


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
		if sticky:
			velocity.x = clamp(velocity.x, -15, 15)
			velocity.x += direction * speed * delta
		else:
			velocity.x = direction * speed
		if current_terrain == Terrain.TOWER:
			velocity.x -= 50
	else:
		if is_on_floor() and current_terrain == Terrain.ICY:
			drag = 0.02
		else:
			drag = speed
		velocity.x = move_toward(velocity.x, 0, drag)
	if (
		Input.is_action_just_pressed("jump") and is_on_floor()
		or Input.is_action_just_pressed("jump") and current_terrain == Terrain.UNDERWATER
	):
		if sticky:
			velocity.y = -jump * .5
		else:
			velocity.y = -jump

	move_and_slide()


func change_mode(new_mode: int) -> void:
	match current_terrain:
		Terrain.GRASSY:
			speed = 100
		Terrain.CANDY:
			pass
		Terrain.ICY:
			speed = 100
		Terrain.TOWER:
			pass
		Terrain.FACTORY:
			speed = 100
		Terrain.DARK:
			light.visible = true
			darklight.visible = false
		Terrain.DESERT:
			jump = 300
		Terrain.DWARVEN:
			pass
		Terrain.UNDERWATER:
			jump = 300
			gravity = 500
			speed = 100
		Terrain.ANIMAL:
			pass
		Terrain.HOME:
			pass
		Terrain.MOON:
			speed = 100
			jump = 300
			gravity = 500
	current_mode = new_mode
	current_terrain = Terrain.values()[new_mode]
	match current_terrain:
		Terrain.GRASSY:
			speed = 80
		Terrain.CANDY:
			pass
		Terrain.ICY:
			speed = 80
		Terrain.TOWER:
			pass
		Terrain.FACTORY:
			speed = 120
		Terrain.DARK:
			light.visible = false
			darklight.visible = true
		Terrain.DESERT:
			jump = 400
		Terrain.DWARVEN:
			pass
		Terrain.UNDERWATER:
			jump = 100
			gravity = 300
			speed = 50
		Terrain.ANIMAL:
			pass
		Terrain.HOME:
			pass
		Terrain.MOON:
			speed = 25
			jump = 200
			gravity = 200


func hurt(amount: int = 10, pos: Vector2 = global_position) -> void:
	global_position += -global_position.direction_to(pos) * amount * 1.6
	health -= amount
	print_debug("health" + str(health))
	if health <= 0:
		respawn()


func respawn() -> void:
	global_position = respawn_point.global_position


func checkpoint(area) -> void:
	respawn_point.global_position = area.global_position
