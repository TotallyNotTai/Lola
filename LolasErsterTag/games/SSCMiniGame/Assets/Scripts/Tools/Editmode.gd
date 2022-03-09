extends Area2D


func _ready():
	pass



func _on_Editmode_mouse_entered():
	$ColorRect.color = "#ecc486"


func _on_Editmode_mouse_exited():
	$ColorRect.color = "#ffffff"


