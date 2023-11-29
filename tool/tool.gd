extends Area2D

enum Tool {
	DEATHSICKLE,
	CORROSIVEBOMB,
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

@onready var sprite2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape2d: CollisionShape2D = $CollisionShape2D


func _ready():
	collision_shape2d.disabled = true


func _process(_delta):
	if Input.is_action_just_pressed("swing") && can_act:
		can_act = false
		swing()
	elif Input.is_action_just_pressed("special") && can_act:
		can_act = false
		special()
	var mouse_position = get_global_mouse_position()
	set_rotation(global_position.direction_to(mouse_position).angle())


func change_mode(new_terrain: int) -> void:
	current_tool = Tool.values()[new_terrain]
	sprite2d.region_rect = Rect2(0, new_terrain * 16, 64, 16)


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
		Tool.CORROSIVEBOMB:
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
