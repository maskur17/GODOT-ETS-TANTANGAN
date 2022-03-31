extends "res://Scrip/pola.gd"

var scaling = 1
var rotasi = 0
var speed = 0.1
var rotasispeed = 2
onready var trans = 0
var transspeed = 5

func _process(delta):
	rotasi += rotasispeed
	scaling += speed
	trans += transspeed
	if rotasi >= 360:
		rotasi = 0
	if scaling >= 1.2:
		speed*= -1
	elif scaling <= 0.5:
		speed *= -1
	if trans >= get_viewport().size.x/2 || trans <= -1*get_viewport().size.x/2:
		transspeed *= -1
	update()

# Translating then Rotating
func translateXrotate(rotate, xTrans, yTrans, center:Vector2):
	var newCenter : PoolVector2Array
	newCenter.insert(0, center)
	
	# Translate Center Point First
	theMatrix = matrix3x3SetIdentity()
	translate2(xTrans, yTrans)
	newCenter = transformPoints2(1, newCenter)
	# Rotate
	theMatrix = matrix3x3SetIdentity()
	rotate2(rotate, newCenter[0])
	
	return newCenter[0]

# Rotating and Scaling
func rotateXscaling(rotate, xScale, yScale, center:Vector2):
	theMatrix = matrix3x3SetIdentity()
	rotate2(rotate, center)
	scale2(xScale, yScale, center)

func _draw():
	var width = get_viewport().size.x
	var height = get_viewport().size.y
	var radius = 100
	var x
	var y
	var centers : PoolVector2Array
	var newCenter : PoolVector2Array
	
	theMatrix = matrix3x3SetIdentity()
	centers.insert(0, Vector2(width/2-radius*2, height/2-radius*2))
	centers.insert(1, Vector2(width/2, height/2-radius*2))
	centers.insert(2, Vector2(width/2+radius*2, height/2-radius*2))
	
	newCenter.insert(0, translateXrotate(rotasi, trans, 0, centers[0]))
	scale2(scaling, scaling, newCenter[0])
	createA(newCenter[0], radius, Color.red)
	
	theMatrix = matrix3x3SetIdentity()
	newCenter.insert(0, translateXrotate(rotasi, trans, 0, centers[1]))
	scale2(scaling, scaling, newCenter[0])
	createB(newCenter[0], radius, Color.red)
	
	theMatrix = matrix3x3SetIdentity()
	newCenter.insert(0, translateXrotate(rotasi, trans, 0, centers[2]))	
	scale2(scaling, scaling, newCenter[0])
	createC(newCenter[0], radius, Color.red)

	theMatrix = matrix3x3SetIdentity()
	centers.insert(0, Vector2(width/2-radius*2, height/2+radius*2))
	centers.insert(1, Vector2(width/2, height/2+radius*2))
	centers.insert(2, Vector2(width/2+radius*2, height/2+radius*2))
	
	newCenter.insert(0, translateXrotate(rotasi, -1*trans, 0, centers[0]))
	scale2(scaling, scaling, newCenter[0])
	createA(newCenter[0], radius, Color.red)
	
	theMatrix = matrix3x3SetIdentity()
	newCenter.insert(0, translateXrotate(rotasi, -1*trans, 0, centers[1]))
	scale2(scaling, scaling, newCenter[0])
	createB(newCenter[0], radius, Color.red)
	
	theMatrix = matrix3x3SetIdentity()
	newCenter.insert(0, translateXrotate(rotasi, -1*trans, 0, centers[2]))	
	scale2(scaling, scaling, newCenter[0])
	createC(newCenter[0], radius, Color.red)
	

func _on_Aboutme_pressed():
	get_tree().change_scene("res://Scene/Control.tscn")
