extends Node2D

onready var sprite = $AnimatedSprite
onready var playerDetectionZone = $PlayerDetectionZone

# func _process(delta):
# 	var player = playerDetectionZone.player
# 	if player != null:
# 		sprite.playing = false
