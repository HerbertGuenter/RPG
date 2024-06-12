extends Area2D

# Signal to notify when the power-up is picked up
signal picked_up

# This function is called when the node enters the scene tree
func _ready():
	# Connect the body_entered signal to the _on_PowerUp_body_entered function
	connect("body_entered", Callable(self, "_on_PowerUp_body_entered"))

# This function is called when another body enters the power-up's area
func _on_PowerUp_body_entered(body):
	# Debug print statement
	print("Body entered by: ", body.name)
	
	# Assuming the player has a group named "Player"
	if body.is_in_group("Player"):
		# Emit the picked_up signal
		emit_signal("picked_up")
		# Optionally, you can also hide or queue_free the power-up
		queue_free() # Removes the power-up from the scene
