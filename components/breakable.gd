extends Node
signal breakable_hit
@export var health: int = 1
var my_mode: int = 0


func _ready():
	$"../Area2D".area_entered.connect(breakable)
	my_mode = $"../Mode".my_mode


func breakable(area: Node2D) -> void:
	if area.is_in_group("tool"):
		if area.current_tool == my_mode && area.is_swinging:
			health -= 1
			emit_signal("breakable_hit")
			if health <= 0:
				get_parent().queue_free()
