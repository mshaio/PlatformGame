extends Area2D

func _ready():
	$AnimatedSprite.play("Idle")
	pass # Replace with function body.

func _on_Crown_body_entered(body):
	if "Player" in body.name:
		body.crown_power_up()
		queue_free()
