extends CharacterBody2D

var speed = 35
var player_chase = false
var player = null

var health = 100
var player_inattack_zone = false

# Reference to the AudioStreamPlayer2D node
@onready var audio_player = $AudioStreamPlayer2D

func _physics_process(delta):
	deal_with_damage()
	
	if player_chase:
		position += (player.position - position) / speed

		$AnimatedSprite2D.play("Walk_Kickl")
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false 
	else:
		$AnimatedSprite2D.play("Idle_Kickl")

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	# Play the voice line when the player is detected
	audio_player.play()

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass

func _on_enemy_hit_box_body_entered(body):
	if body.has_method("player"):
		audio_player.play()
		player_inattack_zone = true

func _on_enemy_hit_box_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false
		
func deal_with_damage():
	if player_inattack_zone and Global.player_current_attack == true:
		health -= 20
		print("attacked homophobe :3")
		print(health)
		if health <= 0:
			self.queue_free()
