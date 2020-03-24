extends Sprite


var step
var img_texture : ImageTexture = ImageTexture.new()
var temp_image	: Image = Image.new()
var increment = Vector2(1,1)

func init_image(init_pos : Vector2,last_pos : Vector2):
	print(init_pos)
	print(last_pos)
	var points = []
	if init_pos == last_pos:
		single_dot(init_pos)
		return
	var dx = abs(init_pos.x - last_pos.x)
	var dy = -abs(init_pos.y - last_pos.y)
	var err = dx + dy
	var e2 = 2 * err
	var sx = 1 if init_pos.x < last_pos.x else -1
	var sy = 1 if init_pos.y < last_pos.y else -1
	while true:
		points.append(init_pos)
		if init_pos.x == last_pos.x and init_pos.y == last_pos.y:
			break
		e2 = 2 * err
		if e2 >= dy:
			err += dy
			init_pos.x += sx
		if e2 <= dx:
			err += dx
			init_pos.y += sy
	draw_pixel(points)
	
	
func single_dot(pos):
	temp_image.lock()
	temp_image.set_pixel(pos.x,pos.y,Color.white)
	temp_image.unlock()
	img_texture.create_from_image(temp_image, Texture.FLAG_FILTER | Texture.FLAG_REPEAT)
	self.texture = img_texture
	
func draw_pixel(arr):
	temp_image.create(1024, 600, true, Image.FORMAT_RGBA8)
	for pixel in arr:
		temp_image.lock()
		temp_image.set_pixel(pixel.x, pixel.y, Color.white)
		temp_image.unlock()
	img_texture.create_from_image(temp_image, Texture.FLAG_FILTER | Texture.FLAG_REPEAT)
	self.texture = img_texture
