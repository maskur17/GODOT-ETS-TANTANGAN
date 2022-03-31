extends "res://Scrip/pola.gd"

func _draw():
	var x = get_viewport().size.x
	var y = get_viewport().size.y
	var xA = x/2+320
	var xB = x/2-320
	var xC = x/2
	
	theMatrix = matrix3x3SetIdentity()
	createA(Vector2(xA, y/2), 100, Color.red)
	theMatrix = matrix3x3SetIdentity()
	createB(Vector2(xB, y/2), 100, Color.red)
	theMatrix = matrix3x3SetIdentity()
	createC(Vector2(xC, y/2), 100, Color.red)


func _on_Aboutme_pressed():
	get_tree().change_scene("res://Scene/Control.tscn")
