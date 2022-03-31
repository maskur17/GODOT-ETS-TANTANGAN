extends "res://scrip/matrix.gd"

var resolution : Vector2
var center : Vector2
var theMatrix = [[0,0,0],[0,0,0],[0,0,0]]

# Called when the node enters the scene tree for the first time.
func _ready():
	resolution = get_viewport().size
	center = Vector2(resolution.x/2, resolution.y/2)

func put_pixel(x:float,y:float,color:Color = Color(255, 0,0)):
	draw_primitive(PoolVector2Array([Vector2(x, y)]),
		PoolColorArray([color]),
		PoolVector2Array(), null, 5.0)
func translate2(tx, ty):
	var m
	
	m = matrix3x3SetIdentity()
	m[0][2] = tx
	m[1][2] = ty
	matrix3x3PreMultiply(m, theMatrix)
	
func scale2(sx, sy, refpt):
	var m
	
	m = matrix3x3SetIdentity()
	m[0][0] = sx
	m[0][2] = (1-sx) * refpt.x
	m[1][1] = sy
	m[1][2] = (1-sy) * refpt.y
	matrix3x3PreMultiply(m, theMatrix)
	
func rotate2(a, refpt):
	var m = [[0,0,0],[0,0,0],[0,0,0]]

	m = matrix3x3SetIdentity()
	a = deg2rad(a)
	m[0][0] = cos(a)
	m[0][1] = -sin(a)
	m[0][2] = refpt.x * (1-cos(a)) + refpt.y * sin(a)
	m[1][0] = sin(a)
	m[1][1] = cos(a)
	m[1][2] = refpt.y * (1-cos(a)) - refpt.x * sin(a)
	matrix3x3PreMultiply(m, theMatrix)
	
func transformPoints2(npts, pts):
	var temp 
	
	for k in range (npts):
		temp = theMatrix[0][0] * pts[k].x + theMatrix[0][1] * pts[k].y + theMatrix[0][2]
		pts[k].y = theMatrix[1][0] * pts[k].x + theMatrix[1][1] * pts[k].y + theMatrix[1][2]
		pts[k].x = temp
		
	return pts
#identitas	
