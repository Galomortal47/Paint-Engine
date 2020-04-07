extends Sprite

var pos
var self_pos 
var smoothed_pos

func _ready():
	brush_size()

func _physics_process(delta):
	pos = get_global_mouse_position()
	self_pos = get_global_position()
	smoothed_pos = smoothing(pos,self_pos)
	self.set_position(smoothed_pos)

func _on_Brush_Size_text_changed():
	brush_size()
	pass # Replace with function body.

func brush_size():
	var size = (int(get_parent().get_node("Brush Size").get_text()) * 0.1)
	self.set_scale(Vector2(size,size))

var smooth = 0.5

func smoothing(var B, var A):
	return (A + ((B - A) * smooth))