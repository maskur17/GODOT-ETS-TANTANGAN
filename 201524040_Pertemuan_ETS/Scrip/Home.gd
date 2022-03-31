extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Ilustrasi_pressed():
	get_tree().change_scene("res://Scene/Pola.tscn")


func _on_Vertikal_pressed():
	get_tree().change_scene("res://Scene/Karya2D.tscn")


func _on_Aboutme_pressed():
	get_tree().change_scene("res://Scene/Aboutme.tscn")


func _on_Lintasan_pressed():
	get_tree().change_scene("res://Scene/Lintasan.tscn")
