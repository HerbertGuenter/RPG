extends CharacterBody2D

const speed = 100
var currrent_dir = "none"

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)
	

func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		currrent_dir = "right"
		play_anim(1)
		
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		currrent_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		currrent_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		currrent_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
func play_anim(movemant):
	var dir = currrent_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movemant == 1:
			anim.play("walking_side")
		elif movemant == 0:
			anim.play("side_idle")
			
	if dir == "left":
		anim.flip_h = true
		if movemant == 1:
			anim.play("walking_side")
		elif movemant == 0:
			anim.play("side_idle")
			
			
	if dir == "down":
		anim.flip_h = true
		if movemant == 1:
			anim.play("walking_down")
		elif movemant == 0:
			anim.play("front_idle")
			
	if dir == "up":
		anim.flip_h = true
		if movemant == 1:
			anim.play("walking_up")
		elif movemant == 0:
			anim.play("back_idle")
