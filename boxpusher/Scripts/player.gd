extends CharacterBody2D

const ID = 'player'
const SPEED = 50
var on_drag = false

var moving = {
	KEY_LEFT: {'x': -50, 'y': 0, 'on_pressed': false},
	KEY_RIGHT: {'x': 50, 'y': 0, 'on_pressed': false},
	KEY_UP: {'x': 0, 'y': -50, 'on_pressed': false},
	KEY_DOWN: {'x': 0, 'y': 50, 'on_pressed': false}
	}

func _ready() -> void:
	pass
	
func  _input(event: InputEvent) -> void:
	if event is InputEventKey:
		print(event)
		if event.pressed and not moving[event.keycode].on_pressed:
			position += Vector2(moving[event.keycode].x, moving[event.keycode].y)
		if event.keycode in moving:
			moving[event.keycode].on_pressed = event.pressed
