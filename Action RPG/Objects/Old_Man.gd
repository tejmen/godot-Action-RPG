extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 75
export var FRICTION = 200

var velocity = Vector2.ZERO

onready var sprite = $OldManSprite
onready var PDZ = $PlayerDetectionZone
onready var Textbox = $Textbox
onready var wanderController = $WanderController
onready var softCollisions = $SoftCollision

func _physics_process(delta):
	if PDZ.can_see_player() == true:
		if Input.is_action_just_pressed("action"):
			Textbox.queue_text("Hello my dear child, where have you come from?")
	if wanderController.get_time_left() == 0:
		wanderController.start_wander_timer(rand_range(1,3))
		
	var direction = global_position.direction_to(wanderController.target_position)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0
	
	if softCollisions.is_colliding():
		velocity += softCollisions.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)
