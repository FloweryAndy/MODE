extends Area2D

var can_act = true

@onready var sprite2d: Sprite2D = $Sprite2D
@onready var collision_shape2d: CollisionShape2D = $CollisionShape2D
@onready var sticky: RayCast2D = $Sticky


func _ready():
	sticky.set_deferred("enabled", false)
	set_deferred("monitoring", false)
	body_entered.connect(_on_body_entered)
	sticky.player_exited_sticky.connect(_on_player_exited_sticky)


func _on_body_entered(body: Node2D):
	if body.is_in_group("player") and can_act:
		can_act = false
		sticky.visible = true
		sticky.set_deferred("enabled", true)


func _on_player_exited_sticky():
	if visible:
		can_act = true
		set_deferred("monitoring", true)
		sticky.set_deferred("enabled", false)
