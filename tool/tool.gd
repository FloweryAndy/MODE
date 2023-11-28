extends Node2D

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


func change_mode(new_terrain: int) -> void:
	current_tool = Tool.values()[new_terrain]
