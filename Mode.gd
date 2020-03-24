extends Control


signal mode(mode)
signal draw_mode(draw_mode)

var draw_mode = true

func _ready():
	$ButtonControl/DDA.disabled = true
	$ButtonControl.hide()
	


func _on_DDA_pressed():
	draw_mode = !draw_mode
	emit_signal("draw_mode",draw_mode)
	check_draw_mode()
	emit_signal("mode","DDA")
	$ButtonControl/DDA.disabled = true
	$ButtonControl/Bresenham.disabled = false
	pass # Replace with function body.


func _on_Bresenham_pressed():
	draw_mode = !draw_mode
	emit_signal("draw_mode",draw_mode)
	check_draw_mode()
	emit_signal("mode","BRESENHAM")
	$ButtonControl/Bresenham.disabled = true
	$ButtonControl/DDA.disabled= false
	pass # Replace with function body.


func _on_Button_pressed():
	draw_mode = !draw_mode
	emit_signal("draw_mode",draw_mode)
	check_draw_mode()
	pass # Replace with function body.


func check_draw_mode():
	if draw_mode:
		$Button.text = "Draw Mode : ON"
		$ButtonControl.hide()
	else:
		$Button.text = "Draw Mode : OFF"
		$ButtonControl.show()
