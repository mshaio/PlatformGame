extends KinematicBody2D

var velocity = Vector2()
var on_ground = false
var is_attacking = false
var is_dead = false
var fireball_power = 1

const SPEED = 100
const GRAVITY = 10
const JUMP_POWER = -450
const FLOOR = Vector2(0,-1)
const FIREBALL = preload("res://Fireball.tscn")
const FIREBALL_RED = preload("res://FireballRed.tscn")

func _physics_process(delta):
	if is_dead == false:
		if Input.is_action_pressed("ui_right"):
			if is_attacking == false:
				velocity.x = SPEED
				$AnimatedSprite.play("Run")
				$AnimatedSprite.flip_h = false
				if sign($Position2D.position.x) == -1:
					$Position2D.position.x *= -1
		elif Input.is_action_pressed("ui_left"):
			if is_attacking == false:
				velocity.x = -SPEED
				$AnimatedSprite.play("Run")
				$AnimatedSprite.flip_h = true
				if sign($Position2D.position.x) == 1:
					$Position2D.position.x *= -1
		else:
			velocity.x = 0
			if on_ground && is_attacking == false:
				$AnimatedSprite.play("Idle")
			
		if Input.is_action_pressed("ui_up"):
			if is_attacking == false:
				if on_ground == true:
					on_ground = false
					velocity.y = JUMP_POWER
		
		if Input.is_action_just_pressed("ui_accept") && is_attacking == false:
			is_attacking = true
			$AnimatedSprite.play("Attack")
			var fireball = null
			if fireball_power == 1:
				fireball = FIREBALL.instance() #creates a fireball instance
			else:
				fireball = FIREBALL_RED.instance()
			print($Position2D.position.x)
			if sign($Position2D.position.x) == 1: 
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball) #Adds the fireball to the parent, in the case the StageOne scene		
			fireball.position = $Position2D.global_position #shoots the fireball from where the character is
		
		if is_on_floor():
			on_ground = true
		else:
			if is_attacking == false:
				on_ground = false
				if velocity.y < 0:
					$AnimatedSprite.play("Jump")
				else:
					$AnimatedSprite.play("Fall")
				
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity,FLOOR)
		
		if get_slide_count() > 0:
			#Counts the number of collisions that occur eg: wall, enemy
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					dead()
func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("Dead")
	$CollisionShape2D.disabled = true
	$Timer.start()


func _on_AnimatedSprite_animation_finished():
	is_attacking = false


func _on_Timer_timeout():
	get_tree().change_scene("res://TitleScreen.tscn")

func crown_power_up():
	fireball_power = 2
