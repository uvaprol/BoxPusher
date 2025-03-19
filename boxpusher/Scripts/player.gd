extends CharacterBody2D

var cell_position = [2, 7]
var box_cell_position = [8, 6]
var moving = {
	KEY_LEFT: {'x': -16, 'y': 0, 'cx': -1, 'cy': 0, 'on_pressed': false},
	KEY_RIGHT: {'x': 16, 'y': 0, 'cx': 1, 'cy': 0, 'on_pressed': false},
	KEY_UP: {'x': 0, 'y': -16, 'cx': 0, 'cy': -1, 'on_pressed': false},
	KEY_DOWN: {'x': 0, 'y': 16, 'cx': 0, 'cy': 1, 'on_pressed': false}
	}
var wall = []
var finish = []
func _ready() -> void:
	var walls = $"../TileMap".get_used_cells(1)
	for i in walls:
		wall.append([i.x, i.y])
	var holes = $"../TileMap".get_used_cells(2)
	for i in holes:
		finish.append([i.x, i.y])
	
	
func  _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode in moving:
		if (
			(event.pressed) and
			(not moving[event.keycode].on_pressed) and
			(not ([cell_position[0] + moving[event.keycode].cx, cell_position[1] + moving[event.keycode].cy] in wall))
		):
			if position + Vector2(moving[event.keycode].x, moving[event.keycode].y) == $"../Box".position:
				$"../Box".position += Vector2(moving[event.keycode].x, moving[event.keycode].y)
				box_cell_position[0] += moving[event.keycode].cx
				box_cell_position[1] += moving[event.keycode].cy
				if box_cell_position in wall:
					$"../Box".rotate(-90)
					get_tree().reload_current_scene()
				elif box_cell_position in finish:
					print('Ура победа')
					$"..".remove_child($"../Box")
					get_tree().paused = true
			position += Vector2(moving[event.keycode].x, moving[event.keycode].y)
			cell_position[0] += moving[event.keycode].cx
			cell_position[1] += moving[event.keycode].cy
		moving[event.keycode].on_pressed = event.pressed


func _on_timer_timeout() -> void:
	$".".rotate(0.5)
