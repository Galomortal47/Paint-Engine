extends Sprite

var test = [ImageTexture.new()]
var img = [Image.new()]
var pos = Vector2(0,0)
var pos2 = Vector2(0,0)
var img_size = Vector2(800,480)
var brush_color = Color(0,0,0,1)
var path = "res://test.png"
var brush_size = 5
var brush_pos_array = [Vector2(0,0),Vector2(0,0)]
var current_layer = 0


func _physics_process(delta):
	if Input.is_action_pressed("ui_mouse") and mouse_in_box():
		pos = get_node("Cursor").smoothed_pos
		pos += (img_size *0.5)
		brush_pos_array.push_front(pos)
		if brush_pos_array.size() >= 3:
			brush_pos_array.pop_back()
#		print(brush_pos_array)
		var a = brush_pos_array[0]
		var b = brush_pos_array[1]
		var speed = 20
		for i in range(1,speed):
			if not b == Vector2(0,0):
				drawn_brush(smoothing(a,b, i * 0.05))
	else:
		brush_pos_array = [Vector2(0,0),Vector2(0,0)]
	if Input.is_action_just_pressed("ui_del"):
		create_image()

func smoothing(var B, var A, smooth):
	return (A + ((B - A) * smooth))

func line():
	pos 

func _ready():
	Input.set_mouse_mode( Input.MOUSE_MODE_HIDDEN )
	pos1 = get_global_mouse_position()
	create_image()

func create_image():
	test[current_layer].create(img_size.x,img_size.y,5)
	img[current_layer].create(img_size.x,img_size.y,false,5)
	test[current_layer].set_data(img[current_layer])
	get_node('Layers').get_child(current_layer).texture = test[current_layer]

func _on_Button_button_down():
	img[current_layer].save_png(path)
	pass # Replace with function body.

func _on_Brush_Size_text_changed():
	brush_size = int(get_node("Brush Size").get_text())
	pass # Replace with function body.

func mouse_in_box():
	if get_global_mouse_position().y < (img_size.y * 0.5) - brush_size:
		if get_global_mouse_position().y > (-img_size.y * 0.5) + brush_size:
			if get_global_mouse_position().x < (img_size.x * 0.5) - brush_size:
				if get_global_mouse_position().x > (-img_size.x * 0.5) + brush_size:
					return true

var pos1 = Vector2()
var pos3 = Vector2()
var x = 0

func drawn_brush(var pos_brush = Vector2(0,0)):
	for i in range(0, brush_size):
			for j in range(0, brush_size):
				img[current_layer].lock()
				img[current_layer].set_pixel(pos_brush.x-i+(brush_size*0.5), pos_brush.y-j+(brush_size*0.5), brush_color)
				img[current_layer].unlock()
	test[current_layer].set_data(img[current_layer])

func _on_ColorPicker_color_changed(color):
	brush_color = color
	pass # Replace with function body.


func _on_Delete_Layer_button_down():
	get_node('Layers').get_child(current_layer).queue_free()
	current_layer -= 1 
	get_node("Current Layer").set_text(str(current_layer + 1))
	pass # Replace with function body.


func _on_New_Layer_button_down():
	var sprite = Sprite.new()
	test.push_back(ImageTexture.new())
	img.push_back(Image.new())
	print(test)
	print(img)
	get_node('Layers').add_child(sprite)
	print(get_node('Layers').get_child_count())
	current_layer = get_node('Layers').get_child_count() -1
	get_node("Current Layer").set_text(str(current_layer + 1))
	create_image()
	pass # Replace with function body.


func _on_Current_Layer_text_changed():
	current_layer = int(get_node("Current Layer").get_text()) -1
	print(current_layer)
	pass # Replace with function body.
