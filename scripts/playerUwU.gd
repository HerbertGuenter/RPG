extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var enemyRED_inattack_range = false
var enemyRED_attack_cooldown = true
var health = 100
var player_alive = true
var attack_ip = false


const speed = 100
var currrent_dir = "none"

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	
	if health <= 0:
		player_alive = false #pookie ded screen
		health = 0
		print("Player is ded (╥﹏╥)")
		self.queue_free()
	

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
			
			
func player():
	pass


func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		
		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$ouchie.start()
		print("Player ouchie  .·°՞(≧□≦)՞°·. ")
		print(health)
		
func enemyRED_attack():
	if enemyRED_inattack_range and enemyRED_attack_cooldown == true:
		health = health - 30
		enemyRED_attack_cooldown = false
		$ouchie.start()
		print("Player ouchie  .·°՞(≧□≦)՞°·. ")
		print(health)


func _on_ouchie_timeout():
	enemy_attack_cooldown = true



