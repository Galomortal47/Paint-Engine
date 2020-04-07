extends Control

var motion = Vector2(0,0)
var pos = Vector2(0,0)
var speed = 1
var max_speed = 5

func _process(delta):
	pos = get_parent().get_local_mouse_position()
	if Input.is_action_pressed("ui_down"):
		if motion.y < max_speed:
			motion.y += speed
		move_mouse()
	elif Input.is_action_pressed("ui_up"):
		if motion.y > -max_speed:
			motion.y += -speed
		move_mouse()
	else:
		motion.y = 0
	if Input.is_action_pressed("ui_right"):
		if motion.x < max_speed:
			motion.x += speed
		move_mouse()
	elif Input.is_action_pressed("ui_left"):
		if motion.x > -max_speed:
			motion.x += -speed
		move_mouse()
	else:
		motion.x = 0

func move_mouse():
	warp_mouse(pos + motion + Vector2(512,300))

