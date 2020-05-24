extends Area2D

const SPEED = 100
var velocity = Vector2()
var direction = 1

func _ready():
	pass # Replace with function body.

func set_fireball_direction(dir):
	print(dir)
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = false
		print("Flipped")
	if dir == 1:
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	velocity.x = SPEED*delta*direction
	translate(velocity)
	$AnimatedSprite.play("shoot")
	#$AnimatedSprite.flip_h = true
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_FireballRed_body_entered(body):
	if "Enemy" in body.name:
		body.dead(3)
	queue_free()
