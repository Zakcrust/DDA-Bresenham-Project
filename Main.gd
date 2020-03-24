extends Node2D

var init_pos
var last_pos

var temp_drawing
var drawing

var drawings = []

var tex : Texture

var DDA = preload("res://DDA.tscn")
var Bresenham = preload("res://Bresenham.tscn")
var drawing_method = "DDA"
var drawing_mode = true



func _input(event):
	if event.is_action_pressed("ui_accept"):
		remove_all_objects()
	pass

func _process(_delta):
	if not drawing_mode:
		return
	if Input.is_action_just_pressed("left_click"):
		if check_mouse_pos():
			return
		init_pos = get_global_mouse_position()
		print(init_pos)
	if Input.is_action_pressed("left_click"):
		if check_mouse_pos() or init_pos == null:
			return
		last_pos = get_global_mouse_position()
		if init_pos == last_pos:
			return
		print(last_pos)
		_draw_mode(drawing_method, "TEMP")
	if Input.is_action_just_released("left_click"):
		if check_mouse_pos() or init_pos == null:
			return
		last_pos = get_global_mouse_position()
		print(last_pos)
		_draw_mode(drawing_method, "FIX")


func _draw_mode(mode, status):
	if mode == "DDA":
		if temp_drawing == null:
			temp_drawing = DDA.instance()
	elif mode == "BRESENHAM":
		if temp_drawing == null:
			temp_drawing = Bresenham.instance()
			
	temp_drawing.init_image(init_pos, last_pos)
	
	if status == "TEMP":
		$TempLayer.show()
		for draws in $TempLayer.get_children():
			if draws == temp_drawing:
				return
		$TempLayer.add_child(temp_drawing)
	
	elif status == "FIX":
		drawing = temp_drawing
		$TempLayer.remove_child(temp_drawing)
		$DrawLayer.add_child(drawing)
		
		for draws in $TempLayer.get_children():
			queue_free()
			
		drawings.append(drawing)
		drawing = null
		temp_drawing = null
		init_pos = Vector2()
		last_pos = Vector2()


func check_mouse_pos():
	var mouse_pos = get_global_mouse_position()
	if mouse_pos.y < 100:
		return true
	if mouse_pos.x < 0 and mouse_pos.x > 1024:
		return true
	return false

func _on_Mode_mode(mode):
	drawing_method = mode
	pass # Replace with function body.


func _on_Mode_draw_mode(draw_mode):
	drawing_mode = draw_mode
	pass # Replace with function body.

func remove_all_objects():
	for object in $DrawLayer.get_children():
		object.queue_free()
