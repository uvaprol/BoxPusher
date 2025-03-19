extends CharacterBody2D

var on_drag = false
var moving = {
	KEY_LEFT: {'x': -50, 'y': 0, 'on_pressed': false},
	KEY_RIGHT: {'x': 50, 'y': 0, 'on_pressed': false},
	KEY_UP: {'x': 0, 'y': -50, 'on_pressed': false},
	KEY_DOWN: {'x': 0, 'y': 50, 'on_pressed': false}
	}
var wall = []
func _ready() -> void:
	var walls = $"../Walls".get_children()
	for w in walls:
		wall.append(w.position)

	
func  _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode in moving:
		if (
			(event.pressed) and
			(not moving[event.keycode].on_pressed) and
			(not position + Vector2(moving[event.keycode].x, moving[event.keycode].y) in wall)
		):
			if position + Vector2(moving[event.keycode].x, moving[event.keycode].y) == $"../Box".position:
				$"../Box".position += Vector2(moving[event.keycode].x, moving[event.keycode].y)
				if $"../Box".position in wall:
					$"../Box".rotate(-90)
			position += Vector2(moving[event.keycode].x, moving[event.keycode].y)
		moving[event.keycode].on_pressed = event.pressed
