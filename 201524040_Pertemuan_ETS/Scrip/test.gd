extends "res://Scrip/pola.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _draw():
	var x = get_viewport().size.x
	var y = get_viewport().size.y
	var center :  PoolVector2Array
	center.insert(0, Vector2(x/2,y/2))
	draw_line(Vector2(0,y/2), Vector2(x, y/2), Color.white)
	theMatrix = matrix3x3SetIdentity()
	translate2(0,200)
	center = transformPoints2(1, center)
	theMatrix = matrix3x3SetIdentity()
	rotate2(50, center[0])
	scale2(1,1, center[0])
	createB(center[0], 100, Color.red)
	theMatrix = matrix3x3SetIdentity()
	
