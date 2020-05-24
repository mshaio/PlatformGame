extends Node2D

var current_shake_priority = 0

func _ready():
	pass # Replace with function body.

func move_camera(vector):
	get_parent().get_node("Player").get_node("Camera2D").offset = Vector2(rand_range(-vector.x,vector.x), rand_range(-vector.y, vector.y))

func screen_shake(shake_length, shake_power, shake_priority):
	if shake_priority > current_shake_priority:
		current_shake_priority = shake_priority
		# self indicates the current script, "move_camera is the function in the script, start, end, duration, interpolation function, rapid approach 0"
		# https://www.youtube.com/watch?v=wQGVOw_CPNs&list=PLyckz_-Rzq6ClGevL2fneJ5YJnMPKWa4M&index=16
		$Tween.interpolate_method(self, "move_camera", Vector2(shake_power, shake_power), Vector2(0,0), shake_length, Tween.TRANS_SINE, Tween.EASE_OUT, 0)
		$Tween.start()


func _on_Tween_tween_completed(object, key):
	#Resets the current_shake_priority to 0 when the shake is done
	current_shake_priority = 0
