extends KinematicBody2D

onready var PDZ = $PlayerDetectionZone
onready var Textbox = $Textbox

func _process(delta):
	if PDZ.can_see_player() == true:
		if Input.is_action_just_pressed("action"):
			Textbox.queue_text("Hello my dear child, where have you come from?")
