extends Node

@export var does_mode_change: bool = false

var current_mode: int = 0

@onready var change_mode_timer: Timer = $ChangeModeTimer


func _ready() -> void:
	change_mode_timer.timeout.connect(change_mode)


func _input(event):
	if event.is_action_pressed("change_mode"):
		change_mode_debug()


func change_mode_debug() -> void:
	change_mode_timer.stop()
	var new_mode = current_mode + 1
	if new_mode > 11:
		new_mode = 0
	current_mode = new_mode
	var changeable_nodes = get_tree().get_nodes_in_group("change_mode")
	for i in changeable_nodes:
		if i.has_method("change_mode"):
			i.change_mode(current_mode)


func change_mode() -> void:
	if does_mode_change:
		var new_mode = randi_range(0, 11)
		if new_mode == current_mode:
			change_mode()
		else:
			current_mode = new_mode
			var changeable_nodes = get_tree().get_nodes_in_group("change_mode")
			for i in changeable_nodes:
				if i.has_method("change_mode"):
					i.change_mode(current_mode)
