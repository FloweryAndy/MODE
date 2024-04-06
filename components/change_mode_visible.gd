extends Node

@export var visible_off_mode: bool = false
@export var visible_on_mode: bool = true
@onready var my_parent: Node2D = $".."
@onready var mode: Node = $"../Mode"


func change_mode(new_mode: int) -> void:
	if !mode.multi_mode:
		my_parent.visible = visible_on_mode if new_mode == mode.my_mode else visible_off_mode
	else:
		my_parent.visible = visible_on_mode if mode.multi_mode_modes[new_mode] else visible_off_mode
	if my_parent.is_visible_in_tree():
		if my_parent is Area2D || my_parent is StaticBody2D || my_parent is RigidBody2D:
			my_parent.set_deferred("monitoring", true)
		else:
			my_parent.set_deferred("monitoring", false)
		if "can_act" in my_parent:
			my_parent.can_act = true
	else:
		if "can_act" in my_parent:
			my_parent.can_act = false
