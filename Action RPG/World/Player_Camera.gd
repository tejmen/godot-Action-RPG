extends Camera2D

onready var player = get_node("/root/World/YSort/Player");


func _process(delta):
	var x = player.position.x
	var y = player.position.y
