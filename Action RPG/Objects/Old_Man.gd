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

export var ACCELERATION = 300
export var MAX_SPEED = 75
export var FRICTION = 200

enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var state = CHASE

onready var sprite = $OldManSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $HurtBox
onready var softCollisions = $SoftCollision
onready var wanderController = $OldManWanderController
onready var animationPlayer = $AnimationPlayer

func _ready():
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			sprite.playing = false
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
			if wanderController.get_time_left() == 0:
				state = pick_random_state([IDLE, WANDER])
				wanderController.start_wander_timer(rand_range(1,5))
		WANDER:
			sprite.playing = true
			seek_player()
			if wanderController.get_time_left() == 0:
				state = pick_random_state([IDLE, WANDER])
				wanderController.start_wander_timer(rand_range(1,5))
			
			var direction = global_position.direction_to(wanderController.target_position)
			velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			sprite.flip_h = velocity.x < 0
			#if global_position.direction_to(wanderController.target_position) <= MAX_SPEED:
			#	state = pick_random_state([IDLE, WANDER])
			#	wanderController.start_wander_timer(rand_range(1,3))
		# CHASE:
		# 	var player = playerDetectionZone.player
		# 	if player != null:
		# 		var direction = global_position.direction_to(player.global_position)
		# 		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		# 	else:
		# 		state = IDLE
		# 	sprite.flip_h = velocity.x < 0
	
	if softCollisions.is_colliding():
		velocity += softCollisions.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

	if PDZ.can_see_player() == true:
		if Input.is_action_just_pressed("action"):
			Textbox.queue_text("Hello my dear child, where have you come from?")

func seek_player():
	if playerDetectionZone.can_see_player():
		# state = CHASE
		pass

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	hurtbox.create_hit_effect()
	knockback = area.knockback_vector * 120
	hurtbox.start_invincibility(0.4)
	

func _on_Stats_no_health():
	queue_free()
	# var enemyDeathEffect = EnemyDeathEffect.instance()
	# get_parent().add_child(enemyDeathEffect)
	# enemyDeathEffect.global_position = global_position

func _on_HurtBox_invinciblitiy_ended():
	animationPlayer.play("Stop")

func _on_HurtBox_invinciblitiy_started():
	animationPlayer.play("Start")
