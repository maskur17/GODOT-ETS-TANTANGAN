extends "res://scrip/Primitif.gd"

var x
var y

func _ready():
	x = get_viewport().size.x
	y = get_viewport().size.y

func bersenham_thick(xa, ya, xb, yb, t):
	var wy
	var wx
	
	line_bersenham(xa, ya, xb, yb)
	if ((yb - ya)/(xb - xa) < 1):
		wy = (t - 1) * sqrt(pow((xb - xa),2) + pow((yb - ya),2)) / (2 * abs(xb - xa))
		for i in wy:
			line_bersenham(xa, (ya - i), xb, (yb - i))
			line_bersenham(xa, (ya + i), xb, (yb + i))
	else:
		wx = (t - 1) * sqrt(pow((xb - xa),2) + pow((yb - ya),2)) / (2 * abs(xb - xa))
		for i in wx:
			line_bersenham((xa - i), ya, (xb - i),  yb)
			line_bersenham((xa + i), ya, (xb + i),  yb)

func line_dda(xa:float, ya:float, xb:float, yb:float, color:Color, type, width:float = 1):
	# Type 1 : Normal Line
	# Type 2 : Dotted Line
	
	var dx = xb - xa
	var dy = yb - ya
	var steps : float
	var xIncrement
	var yIncrement
	var x = xa
	var y = ya
	var pos 
	
	if (abs(dx) > abs(dy)):
		steps = abs(dx)
	else:
		steps = abs(dy)
	
	if (abs(dx) > 0 and abs(dy) > 0):
		pos = 2
	else:
		if (abs(dx) > abs(dy)):
			pos = 0
		else:
			pos = 1
	
	xIncrement = dx / steps
	yIncrement = dy / steps
	
	match type:
		1 : # Normal Line
			put_pixel(round(x), round(y), color)
			for k in steps:
				x += xIncrement
				y += yIncrement
				put_pixel(round(x), round(y), color)

		2 : # Dot Line
			var counter = 0
			var mode = 0 # 0 = line, 1 = free space
	
			put_pixel(round(x), round(y), color)
			for k in steps:
				if (counter > 10):
					counter = 0
				if (counter < 10):
					mode = 1
				if (counter < 5):
					mode = 0
					
				x += xIncrement
				y += yIncrement
				if (mode == 0):
					put_pixel(round(x), round(y), color)
				counter += 1

		
func line_bersenham(xa, ya,xb, yb):
	var dx = abs( xa - xb)
	var dy = abs( ya - yb)
	var p = 2* dy - dx
	var twoDy = 2* dy
	var twoDyDx = 2*( dy - dx)
	var x
	var y
	var xEnd
	var color = Color.yellowgreen
	
	if (xa > xb):
		x = xb
		y = yb
		xEnd = xa
	else :
		x = xa
		y = ya
		xEnd = xb
		
	put_pixel(x, y, color)
	
	while (x < xEnd):
		x += 1
		if (p < 0):
			p += twoDy
		else:
			y += 1
			p += twoDyDx
		put_pixel(x, y, color)
