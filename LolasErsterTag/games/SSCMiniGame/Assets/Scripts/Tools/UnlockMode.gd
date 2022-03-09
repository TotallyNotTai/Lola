extends Area2D


func _ready():
	pass


func _on_UnlockMode_mouse_entered():
	$ColorRect.color = "#ecc486"


func _on_UnlockMode_mouse_exited():
	$ColorRect.color = "#ffffff"
