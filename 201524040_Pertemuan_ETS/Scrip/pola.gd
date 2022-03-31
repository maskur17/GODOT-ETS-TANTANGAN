extends "res://Scrip/fungsi.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#A
func diamond(center : Vector2, hDiag, vDiag, color):
	var x = center.x
	var y = center.y
	var point : PoolVector2Array
	var point1 : PoolVector2Array
	var point2 : PoolVector2Array
	# Top Right Side
	point.insert(0, Vector2(x, y-vDiag/2)) # Top
	point.append(Vector2(x+hDiag/2, y)) # Right
	# Bottom Right Side
	point.append(Vector2(x+hDiag/2, y)) # Right
	point.append(Vector2(x, y+vDiag/2)) # Bottom
	# Bottom Left Side
	point.append(Vector2(x, y+vDiag/2)) # Bottom
	point.append(Vector2(x-hDiag/2, y)) # Left
	# Top Left Side
	point.append(Vector2(x-hDiag/2, y)) # Left
	point.append(Vector2(x, y-vDiag/2)) # Top
	for i in range(4):
		point1.insert(0, point[i*2])
		point1.insert(1, point[i*2+1])
		point2 = transformPoints2(2, point1)
		draw_line(Vector2(point2[0].x, point2[0].y), Vector2(point2[1].x, point2[1].y), color, 1)
#		line_dda(point2[0].x, point2[0].y, point2[1].x, point2[1].y, color, 1)

func createA(center, height, color):
	var x = center.x
	var y = center.y
	var hDiag = height*2
	var vDiag = height*3/5*2
	
	# Midle Diamond
	diamond(Vector2(x, y-height*0.15*2), hDiag, vDiag, color)
	# Top Diamond
	diamond(Vector2(x,y+height*0.15*2), hDiag, vDiag, color)

#B
func createB(center, radius, color):
	var x
	var y
	var point1 : PoolVector2Array
	var point2 : PoolVector2Array
	
	BMidPoint(center.x, center.y, radius-radius/10, color, 0)
	BMidPoint(center.x, center.y, radius, color, 1)
	
func BMidPoint(xCenter, yCenter, radius, color, mode):
	var x = 0
	var y = radius
	var p = 1 - radius
	var limit = radius/20
	var plot = mode
	var line = 0
	
	# Plot first set of points #
	BPlotPoints(xCenter, yCenter, x, y, color, plot, line)
	
	while (x < y):
		x += 1
		limit -= 1
		if (p < 0):
			p += 2*x + 1
		else:
			y -= 1
			p += 2*(x-y) + 1
		if (round(limit) == 0 and mode == 0):
			line = 1
			plot = 1
		elif(limit < 0):
			line = 0
		BPlotPoints(xCenter, yCenter, x, y, color, plot, line)
		if(line == 1):
			line = 0

func BPlotPoints(xCenter, yCenter, x, y, color, mode, line):
	var points : PoolVector2Array
	var plot : PoolVector2Array
	var pm
	if (mode == 1):
		pm = [[1,1],[1,-1],[-1,1],[-1,-1]]
		for i in (2):
			points.insert(0, Vector2(xCenter+(x*pm[i*2][0]), yCenter+(y*pm[i*2][1])))
			points.insert(1, Vector2(xCenter+(x*pm[i*2+1][0]), yCenter+(y*pm[i*2+1][1])))
			plot = transformPoints2(2, points)
			put_pixel(plot[0].x, plot[0].y, color)
			put_pixel(plot[1].x, plot[1].y, color)
			if(line == 1):
				draw_line(Vector2(plot[0].x, plot[0].y), Vector2(plot[1].x, plot[1].y), color, 1)
#				line_dda(plot[0].x, plot[0].y, plot[1].x, plot[1].y, color, 1)
	pm = [[1,1],[-1,1],[1,-1],[-1,-1]]
	for i in (4):
		points.insert(0, Vector2(xCenter+(y*pm[i][0]), yCenter+(x*pm[i][1])))
		plot = transformPoints2(1, points)
		put_pixel(plot[0].x, plot[0].y, color) 

#C
func createC(center, radius, color):
	var x = center.x
	var y = center.y
	segitiga1(Vector2(x, y-radius*0.7), radius*1.1, radius*1.2, Color.red, 1)
	segitiga2(Vector2(x, y+radius*0.7), radius*1.1, radius*1.2, Color.red, 1)
	CMidPoint(x, y, radius, color)
	
func segitiga1(start : Vector2, height, base, color, type, lWidth:float = 1):
	var x = start.x
	var y = start.y
	var points : PoolVector2Array
	var plot : PoolVector2Array
	
	points.insert(0, Vector2(x,y))
	points.append(Vector2(x-base/2, y+height))
	points.append(Vector2(x-base/2, y+height))
	points.append(Vector2(x+base/2, y+height))
	points.append(Vector2(x+base/2, y+height))
	points.append(Vector2(x, y))
	
	for i in (3):
		plot.insert(0, points[i*2])
		plot.insert(1, points[i*2+1])
		plot = transformPoints2(2, plot)
		draw_line(Vector2(plot[0].x, plot[0].y), Vector2(plot[1].x, plot[1].y), color, 1)
#		line_dda(plot[0].x, plot[0].y, plot[1].x, plot[1].y, color, 1)

func segitiga2(start : Vector2, height, base, color, type, lWidth:float = 1):
	var x = start.x
	var y = start.y
	var points : PoolVector2Array
	var plot : PoolVector2Array
	
	points.insert(0, Vector2(x,y))
	points.append(Vector2(x-base/2, y-height))
	points.append(Vector2(x-base/2, y-height))
	points.append(Vector2(x+base/2, y-height))
	points.append(Vector2(x+base/2, y-height))
	points.append(Vector2(x, y))
	
	for i in (3):
		plot.insert(0, points[i*2])
		plot.insert(1, points[i*2+1])
		plot = transformPoints2(2, plot)
		draw_line(Vector2(plot[0].x, plot[0].y), Vector2(plot[1].x, plot[1].y), color, 1)
#		line_dda(plot[0].x, plot[0].y, plot[1].x, plot[1].y, color, 1)

func CMidPoint(xCenter, yCenter, radius, color):
	var x = 0
	var y = radius
	var p = 1 - radius
	
	# Plot first set of points #
	CPlotPoints(xCenter, yCenter, x, y, color)
	while (x < y):
		x += 1
		if (p < 0):
			p += 2*x + 1
		else:
			y -= 1
			p += 2*(x-y) + 1
		CPlotPoints(xCenter, yCenter, x, y, color)
	
func CPlotPoints(xCenter, yCenter, x, y, color):
	var points : PoolVector2Array
	var plot : PoolVector2Array
	var pm = [[1,1],[1,-1],[-1,1],[-1,-1]]
	for i in (4):
		points.insert(0, Vector2(xCenter+(x*pm[i][0]), yCenter+(y*pm[i][1])))
		plot = transformPoints2(1, points)
		put_pixel(plot[0].x, plot[0].y, color)
		pm = [[1,1],[-1,1],[1,-1],[-1,-1]]
	for i in (4):
		points.insert(0, Vector2(xCenter+(y*pm[i][0]), yCenter+(x*pm[i][1])))
		plot = transformPoints2(1, points)
		put_pixel(plot[0].x, plot[0].y, color)
