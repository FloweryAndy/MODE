extends Node2D

@export var swing_speed = 9
@export var my_mode: int = 0
@export var current_mode: int = 0

var facing_left = true

@onready var pin_joint2d1: PinJoint2D = $PinJoint2D1
@onready var pin_joint2d2: PinJoint2D = $PinJoint2D2
@onready var pin_joint2d3: PinJoint2D = $PinJoint2D3
@onready var timer: Timer = $Timer
@onready var vine1: RigidBody2D = $Vine1
@onready var vine2: RigidBody2D = $Vine2
@onready var vine3: RigidBody2D = $Vine3
@onready var collision_shape2d1: CollisionShape2D = $Vine1/CollisionShape2D
@onready var collision_shape2d2: CollisionShape2D = $Vine2/CollisionShape2D
@onready var collision_shape2d3: CollisionShape2D = $Vine3/CollisionShape2D


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func change_mode(new_mode: int) -> void:
	if new_mode == my_mode:
		collision_shape2d1.set_deferred("disabled", false)
		collision_shape2d2.set_deferred("disabled", false)
		collision_shape2d3.set_deferred("disabled", false)
		visible = true
		timer.start()
	elif current_mode == my_mode:
		collision_shape2d1.set_deferred("disabled", true)
		collision_shape2d2.set_deferred("disabled", true)
		collision_shape2d3.set_deferred("disabled", true)
		visible = false
		timer.stop()
	current_mode = new_mode


func _on_timer_timeout() -> void:
	if facing_left:
		facing_left = false
		pin_joint2d1.motor_target_velocity = -swing_speed
	else:
		facing_left = true
		pin_joint2d1.motor_target_velocity = swing_speed
