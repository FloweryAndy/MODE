extends Area2D

@export var speed = 64
@export var jump = 300
@export var drag = 1.0
var target_position: Vector2
var player: Node2D
@onready var sprite2d: Sprite2D = $Sprite2D
@onready var collision_shape2d: CollisionShape2D = $CollisionShape2D
@onready var navigation_agent2d: NavigationAgent2D = $NavigationAgent2D
@onready var point_light2d: PointLight2D = $PointLight2D


func _ready():
	player = get_tree().get_first_node_in_group("player")
	target_position = player.position
	navigation_agent2d.target_position = target_position
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _physics_process(delta):
	if visible:
		target_position = player.global_position
		navigation_agent2d.target_position = target_position
		var direction = global_position.direction_to(navigation_agent2d.get_next_path_position())
		var velocity = direction * speed * delta
		global_position += velocity
		sprite2d.flip_h = direction.x < 0
		sprite2d.frame = direction.y < 0


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(5, global_position)


func _on_body_exited(body):
	if body.is_in_group("player"):
		body.hurt(5, global_position)
