extends "res://scrip/Line.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func persegi(point : Vector2, length, color, type, lWidth:float = 1):
	var x = point.x
	var y = point.y
	
	if (type == 1 or 2):
		# Top Side
		line_dda(x, y, x+length, y, color, type, lWidth)
		# Right Side
		line_dda(x+length, y, x+length, y+length, color, type, lWidth)
		# Bottom Side
		line_dda(x+length, y+length, x, y+length, color, type, lWidth)
		# Left Side
		line_dda(x, y, x, y+length, color, type, lWidth)
		
func persegi_panjang(point : Vector2, length, height, color, type, lWidth:float = 1):
	var x = point.x
	var y = point.y
	
	if (type == 1 or 2):
		# Top Side
		line_dda(x, y, x+length, y, color, type, lWidth)
		# Right Side
		line_dda(x+length, y, x+length, y+height, color, type, lWidth)
		# Bottom Side
		line_dda(x+length, y+height, x, y+height, color, type, lWidth)
		# Left Side
		line_dda(x, y, x, y+height, color, type, lWidth)
		
func segitiga_siku(point : Vector2, height, base, color, type, lWidth:float = 1):
	var x = point.x
	var y = point.y
	
	if (type == 1 or 2):
		# Vertical Side
		line_dda(x, y, x, y+height, color, type, lWidth)
		# Horizontal Side
		line_dda(x, y+height, x+base, y+height, color, type, lWidth)
		# Tilted Side
		line_dda(x, y, x+base, y+height, color, type, lWidth)

func trapesium_siku(point : Vector2, height, top, base, color, type, lWidth:float = 1):
	var x = point.x
	var y = point.y
	
	# Vertical Side
	line_dda(x, y, x, y+height, color, type, lWidth)
	# Top Side
	line_dda(x, y, x+top, y, color, type, lWidth)
	# Bottom Side
	line_dda(x, y+height, x+base, y+height, color, type, lWidth)
	# Tilted Side
	line_dda(x+top, y, x+base, y+height, color, type, lWidth)
		
func ketupat(point : Vector2, diagonal, color, type, lWidth:float = 1):
	var x = point.x
	var y = point.y
	
	# Top Right Side
	line_dda(x, y, x+diagonal/2, y+diagonal/2, color, type, lWidth)
	# Bottom Right Side
	line_dda(x+diagonal/2, y+diagonal/2, x, y+diagonal, color, type, lWidth)
	# Bottom Left Side
	line_dda(x, y+diagonal, x-diagonal/2, y+diagonal/2, color, type, lWidth)
	# Top Left Side
	line_dda(x-diagonal/2, y+diagonal/2, x, y, color, type, lWidth)

func jajaran_genjang(point : Vector2, length, height, offset, color, type, lWidth:float = 1):
	var x = point.x
	var y = point.y
	
	# Top Side
	line_dda(x, y, x+length, y, color, type, lWidth)
	# Right Side
	line_dda(x+length, y, x+length+offset, y+height, color, type, lWidth)
	# Bottom Side
	line_dda(x+length+offset, y+height, x+offset, y+height, color, type, lWidth)
	# Left Side
	line_dda(x+offset, y+height, x, y, color, type, lWidth)
	
func layang_layang(point : Vector2, horizontal, vertical, offset, color, type, lWidth:float = 1):
	var x = point.x
	var y = point.y
	
	# Top Right Side
	line_dda(x, y, x+horizontal/2, y+offset, color, type, lWidth)
	# Bottom Right Side
	line_dda(x+horizontal/2, y+offset, x, y+vertical, color, type, lWidth)
	# Bottom Left Side
	line_dda(x, y+vertical, x-horizontal/2, y+offset, color, type, lWidth)
	# Top Left Side
	line_dda(x-horizontal/2, y+offset, x, y, color, type, lWidth)
	
func circleMidPoint(xCenter, yCenter, radius, color):
	var x = 0
	var y = radius
	var p = 1 - radius
	
	# Plot first set of points #
	circlePlotPoints(xCenter, yCenter, x, y, color)
	
	while (x < y):
		x += 1
		if (p < 0):
			p += 2*x + 1
		else:
			y -= 1
			p += 2*(x-y) + 1
		circlePlotPoints(xCenter, yCenter, x, y, color)
		
func circlePlotPoints(xCenter, yCenter, x, y, color):
	put_pixel(xCenter + x, yCenter + y, color) #1
	put_pixel(xCenter - x, yCenter + y, color) #2
	put_pixel(xCenter + x, yCenter - y, color) #3
	put_pixel(xCenter - x, yCenter - y, color) #4
	put_pixel(xCenter + y, yCenter + x, color) #5
	put_pixel(xCenter - y, yCenter + x, color) #6
	put_pixel(xCenter + y, yCenter - x, color) #7
	put_pixel(xCenter - y, yCenter - x, color) #8
	
func ellipseMidPoint(center: Vector2, rx, ry, color, rotate:bool):
	var rx2 = rx * rx
	var ry2 = ry * ry
	var twoRx2 = 2 * rx2
	var twoRy2 = 2 * ry2
	var x = 0
	var y = ry
	var px = 0
	var py = twoRx2 * y
	var p
	
	p = round (ry2 - (rx2 * ry) + (0.25 * rx2))
	while(px < py):
		x += 1
		px += twoRy2
		if (p < 0):
			p += ry2 + px
		else:
			y -= 1
			py -= twoRx2
			p += ry2 + px - py
			
		if (rotate == false):
			ellipsePlotPoints(center.x, center.y, x, y, color)
		else :
			ellipsePlotPointsSpin(center.x, center.y, x, y, color)
		
	p = round (ry2 * (x + 0.5) * (x + 0.5) + rx2 * (y - 1) * (y - 1) - rx2 * ry2)
	while (y > 0):
		y -= 1
		py -= twoRx2
		if (p > 0):
			p += rx2 - py
		else:
			x += 1
			px += twoRy2
			p += rx2 - py + px
			
		if (rotate == false):
			ellipsePlotPoints(center.x, center.y, x, y, color)
		else :
			ellipsePlotPointsSpin(center.x, center.y, x, y, color)
		
func ellipsePlotPoints(xCenter, yCenter, x, y, color):
	put_pixel(xCenter + x, yCenter + y, color)
	put_pixel(xCenter - x, yCenter + y, color)
	put_pixel(xCenter + x, yCenter - y, color)
	put_pixel(xCenter - x, yCenter - y, color)

func ellipsePlotPointsSpin(xCenter, yCenter, x, y, color):
	var point1 : PoolVector2Array
	var point2 : PoolVector2Array
	var plusminus = [[1,1],[-1,1],[1,-1],[-1,-1]]
	for i in range (4):
		point1.insert(0, Vector2(xCenter+(x*plusminus[i][0]), yCenter+(y*plusminus[i][1])))
		point2.insert(0, point1[0])
		theMatrix = matrix3x3SetIdentity()
		rotate2(45, Vector2(xCenter, yCenter))
		point2 = transformPoints2(1, point2)
		put_pixel(point2[0].x, point2[0].y, color)
	

func segi_lima(center, length, color, type):
	var point1 : PoolVector2Array
	var point2 : PoolVector2Array
	point1.insert(0, Vector2(center.x,center.y-length))
	for i in range (5):
		point2.insert(0,point1[0])
		theMatrix = matrix3x3SetIdentity()
		rotate2(72, center)
		point2 = transformPoints2(1, point2)
		line_dda(point1[0].x, point1[0].y, point2[0].x, point2[0].y, color, type)
		point1.insert(0, point2[i-i])
		
func segi_enam(center, length, color, type):
	var point1 : PoolVector2Array
	var point2 : PoolVector2Array
	point1.insert(0,Vector2(center.x,center.y-length))
	for i in range (6):
		point2.insert(0,point1[0])
		theMatrix = matrix3x3SetIdentity()
		rotate2(60, center)
		point2 = transformPoints2(1, point2)
		line_dda(point1[0].x, point1[0].y, point2[0].x, point2[0].y, color, type)
		point1.insert(0, point2[i-i])
