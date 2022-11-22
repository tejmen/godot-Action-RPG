extends Node2D

onready var sprite = $AnimatedSprite
onready var playerDetectionZone = $PlayerDetectionZone

func _ready():
	sprite.frame = 0

func _process(delta):
	var player = playerDetectionZone.player
	if player != null:
		sprite.frame = 1

