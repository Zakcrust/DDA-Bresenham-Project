extends Sprite

var step
var img_texture : ImageTexture = ImageTexture.new()
var temp_image	: Image = Image.new()
var increment = Vector2()

func init_image(init_pos : Vector2,last_pos : Vector2):
	print(init_pos)
	print(last_pos)
	temp_image.create(1024, 600, true, Image.FORMAT_RGBA8)
	if init_pos == last_pos:
		single_dot(init_pos)
		return
	var x_delta = abs(init_pos.x - last_pos.x)
	var y_delta = abs(init_pos.y - last_pos.y)
	if y_delta > x_delta:
		step = y_delta
	else:
		step = x_delta
	increment.x = x_delta / step
	increment.y = y_delta / step
	if init_pos.x > last_pos.x:
		increment.x *= -1
	if init_pos.y > last_pos.y:
		increment.y *= -1
		
	if init_pos < last_pos:
		while init_pos < last_pos:
			init_pos.x += increment.x
			init_pos.y += increment.y
			temp_image.lock()
			temp_image.set_pixel(init_pos.x, init_pos.y, Color.red)
			temp_image.unlock()

	elif init_pos > last_pos:
		while init_pos > last_pos:
			init_pos.x += increment.x
			init_pos.y += increment.y
			temp_image.lock()
			temp_image.set_pixel(init_pos.x, init_pos.y, Color.red)
			temp_image.unlock()
	img_texture.create_from_image(temp_image, Texture.FLAG_FILTER | Texture.FLAG_REPEAT)
	self.texture = img_texture
	
	
func single_dot(pos):
	temp_image.lock()
	temp_image.set_pixel(pos.x,pos.y,Color.red)
	temp_image.unlock()
	img_texture.create_from_image(temp_image, Texture.FLAG_FILTER | Texture.FLAG_REPEAT)
	self.texture = img_texture
