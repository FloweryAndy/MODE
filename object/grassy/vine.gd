extends Node2D

@export var swing_speed: float = 9.8

var facing_left = true

@onready var pin_joint2d1: PinJoint2D = $PinJoint2D1
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	if facing_left:
		facing_left = false
		pin_joint2d1.motor_target_velocity = -swing_speed
	else:
		facing_left = true
		pin_joint2d1.motor_target_velocity = swing_speed
