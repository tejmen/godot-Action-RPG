extends "res://Enemies/WanderController.gd"



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func update_target_position():
	var target_dir = int(rand_range(0,4))
	var target_vector = Vector2(0,0)
	match target_dir: # Pick Random direction
		0: # North
			target_vector.y = rand_range(0,wander_range)
			target_vector.x = 0
		1: # East
			target_vector.x = rand_range(0,wander_range)
			target_vector.y = 0
		2: # North
			target_vector.y = rand_range(-wander_range,0)
			target_vector.x = 0
		3: # East
			target_vector.x = rand_range(-wander_range,0)
			target_vector.y = 0

	target_position = start_position + target_vector

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
