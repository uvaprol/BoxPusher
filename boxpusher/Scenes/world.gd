extends Node2D

func _ready() -> void:
	print($TileMap.get_used_cells(1))
