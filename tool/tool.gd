extends Area2D

enum Tool {
	DEATHSICKLE,
	PEPPERMINTBOMB,
	HEAVYSLEDGEHAMMER,
	FLOATYUMBRELLA,
	BIGGIFYGUN,
	SPIRITLANTERN,
	WATERGUN,
	GOLDENPICKAXE,
	GRAPPLEGUN,
	SHEPHERDCANE,
	SHRINKRAY,
	GRAVITYGUN
}
@export var current_tool = Tool.DEATHSICKLE
@export var can_act = true
@export var is_swinging = false

var current_mode = 0

@onready var sprite2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape2d: CollisionShape2D = $CollisionShape2D
@onready var point_light2d: PointLight2D = $PointLight2D


func _ready():
	point_light2d.visible = false
	collision_shape2d.disabled = true
	connect("body_entered", Callable(_on_body_entered))


func _process(_delta):
	if Input.is_action_just_pressed("swing") && can_act:
		can_act = false
		swing()
	elif Input.is_action_just_pressed("special") && can_act:
		can_act = false
		special()
	var mouse_position = get_global_mouse_position()
	set_rotation(global_position.direction_to(mouse_position).angle())


func change_mode(new_mode: int) -> void:
	match current_tool:
		Tool.DEATHSICKLE:
			pass
		Tool.PEPPERMINTBOMB:
			pass
		Tool.HEAVYSLEDGEHAMMER:
			pass
		Tool.FLOATYUMBRELLA:
			pass
		Tool.BIGGIFYGUN:
			pass
		Tool.SPIRITLANTERN:
			point_light2d.visible = false
		Tool.WATERGUN:
			pass
		Tool.GOLDENPICKAXE:
			pass
		Tool.GRAPPLEGUN:
			point_light2d.visible = false
		Tool.SHEPHERDCANE:
			pass
		Tool.SHRINKRAY:
			pass
		Tool.GRAVITYGUN:
			pass
	current_mode = new_mode
	current_tool = Tool.values()[new_mode]
	sprite2d.region_rect = Rect2(0, new_mode * 16, 64, 16)
	match current_tool:
		Tool.DEATHSICKLE:
			pass
		Tool.PEPPERMINTBOMB:
			pass
		Tool.HEAVYSLEDGEHAMMER:
			pass
		Tool.FLOATYUMBRELLA:
			pass
		Tool.BIGGIFYGUN:
			pass
		Tool.SPIRITLANTERN:
			point_light2d.visible = true
		Tool.WATERGUN:
			pass
		Tool.GOLDENPICKAXE:
			pass
		Tool.GRAPPLEGUN:
			point_light2d.visible = true
		Tool.SHEPHERDCANE:
			pass
		Tool.SHRINKRAY:
			pass
		Tool.GRAVITYGUN:
			pass


func swing() -> void:
	animation_player.play("swing")
	is_swinging = true
	collision_shape2d.disabled = false
	await animation_player.animation_finished
	animation_player.play("RESET")
	is_swinging = false
	collision_shape2d.disabled = true
	can_act = true


func special() -> void:
	match current_tool:
		Tool.DEATHSICKLE:
			pass
		Tool.PEPPERMINTBOMB:
			pass
		Tool.HEAVYSLEDGEHAMMER:
			pass
		Tool.FLOATYUMBRELLA:
			pass
		Tool.BIGGIFYGUN:
			pass
		Tool.SPIRITLANTERN:
			pass
		Tool.WATERGUN:
			pass
		Tool.GOLDENPICKAXE:
			pass
		Tool.GRAPPLEGUN:
			pass
		Tool.SHEPHERDCANE:
			pass
		Tool.SHRINKRAY:
			pass
		Tool.GRAVITYGUN:
			pass
	can_act = true


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("breakable"):
		if current_mode == body.my_mode:
			body.breakable()
