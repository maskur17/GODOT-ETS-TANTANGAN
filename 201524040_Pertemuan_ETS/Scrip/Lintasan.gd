extends "res://Scrip/pola.gd"

var radius = 100
var height = radius*2
var base = radius*3
var color
var index = 0
var size 
var scaling = 1
var scalingspeed = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func segi_lima(center, length, color, type, lWidth : float = 1):
	var point1 : PoolVector2Array
	var point2 : PoolVector2Array
	var points : PoolVector2Array
	point1.insert(0, Vector2(center.x,center.y-length))
	for i in range (5):
		point2.insert(0,point1[0])
		theMatrix = matrix3x3SetIdentity()
		rotate2(72, center)
		point2 = transformPoints2(1, point2)
		points.insert(i, point2[0])
		point1.insert(0, point2[i-i])
	return points
	
func lineDDA(xa : float, ya : float, xb : float, yb : float):
	var dx = xb - xa
	var dy = yb - ya
	var steps
	var xIncrement
	var yIncrement
	var x = xa
	var y = ya
	var res = PoolVector2Array()
	
	if (abs(dx) > abs(dy)) :
		steps = abs(dx)
	else : 
		steps = abs(dy)
		
	xIncrement = dx/ float(steps)
	yIncrement = dy/ float(steps)
	res.append(Vector2(round(x), round(y)))
	
	for k in steps:
		x += xIncrement
		y += yIncrement
		res.append(Vector2(round(x), round(y)))
	return res
	
func fivepointstar(Center : Vector2, radius):
	var res = PoolVector2Array()
	var points = PoolVector2Array()
	points.insert(0, Vector2(Center.x, (Center.y - radius)))
	
	for i in range(1, 10):
		var pt = PoolVector2Array()
		pt.insert(0, points[i-1])
		
		theMatrix = matrix3x3SetIdentity()
		rotate2(36, Center)
		if (i%2 == 0):#genap
			scale2(2, 2, Center)
		else:
			scale2(0.5, 0.5, Center)
		pt = transformPoints2(1, pt)
		points.insert(i, pt[0])
	
	for i in range (1, 10):
		res.append_array(lineDDA(points[i-1].x, points[i-1].y, points[i].x, points[i].y))
	res.append_array(lineDDA(points[9].x, points[9].y, points[0].x, points[0].y))
	return res		
	
func drawlintasan(center : Vector2, base, height, color):
	var x = center.x
	var y = center.y
	var line : PoolVector2Array
	var point : PoolVector2Array
	var temp : PoolVector2Array
	
	theMatrix = matrix3x3SetIdentity()
	rotate2(216, center)
	line.append(Vector2(x, y-100))
	line = transformPoints2(1, line) #mendapatkan titik dari segitiga
	point.append_array(lineDDA(line[0].x, line[0].y+100, line[0].x, line[0].y))
	temp = fivepointstar(center, 100)
	theMatrix = matrix3x3SetIdentity()
	rotate2(216, center)
	point.append_array(transformPoints2(temp.size(), temp))
	point.append_array(lineDDA(line[0].x, line[0].y, line[0].x+50, line[0].y+50))
	point.append_array(lineDDA(line[0].x+50, line[0].y+50, line[0].x, line[0].y+100))
	for i in point.size():
		put_pixel(point[i].x, point[i].y, Color.white)
	
	return point 

func _draw():
	var x = get_viewport().size.x
	var y = get_viewport().size.y
	var point : PoolVector2Array
	point = drawlintasan(Vector2(x/2, y/2), base, height, Color.white)
	size = point.size()
	theMatrix = matrix3x3SetIdentity()
	scale2(scaling, scaling, point[index])
	createC (point[index], 30, Color.green)
	
func _process(delta):
	index += 2
	scaling += scalingspeed
	if scaling >= 1.5:
		scalingspeed *= -1
	if scaling <= 1:
		scalingspeed *= -1
	if index >= size-1 : 
		index = 0 
	update()


func _on_Aboutme_pressed():
	get_tree().change_scene("res://Scene/Control.tscn")
