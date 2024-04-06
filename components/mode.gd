extends Node

@export_enum("Grassy", "Candy", "Icy", "Tower", "Factory", "Dark", "Desert", "Dwarven", "Underwater", "Animal", "Home", "Moon") var my_mode: int = 0
@export var multi_mode: bool = false
@export var multi_mode_modes: Array[bool] = [false, false, false, false, false, false, false, false, false, false, false, false]
