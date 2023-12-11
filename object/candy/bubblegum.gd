extends Area2D

@export var my_mode: int = 0

var current_mode: int = 0
var can_act = true

@onready var sprite2d: Sprite2D = $Sprite2D
@onready var collision_shape2d: CollisionShape2D = $CollisionShape2D
@onready var sticky: RayCast2D = $Sticky


func _ready():
	visible = false
	sticky.set_deferred("enabled", false)
	set_deferred("monitoring", false)
	body_entered.connect(_on_body_entered)
	sticky.player_exited_sticky.connect(_on_player_exited_sticky)


func _process(_delta):
	pass


func change_mode(new_mode: int) -> void:
	current_mode = new_mode
	if current_mode == my_mode:
		visible = true
		set_deferred("monitoring", true)
		can_act = true
	else:
		visible = false
		set_deferred("monitoring", false)
		sticky.set_deferred("enabled", false)
		can_act = false


func _on_body_entered(body: Node2D):
	if body.is_in_group("player") and can_act:
		can_act = false
		sticky.visible = true
		sticky.set_deferred("enabled", true)


func _on_player_exited_sticky():
	if current_mode == my_mode:
		can_act = true
		set_deferred("monitoring", true)
		sticky.set_deferred("enabled", false)
