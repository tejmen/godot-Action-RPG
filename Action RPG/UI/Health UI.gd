extends Control

var hearts = 16 setget set_hearts
var max_hearts = 16 setget set_max_hearts
var first_set_hearts = true
var set_hearts_num = 1

onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heartUIFull != null:
		if first_set_hearts == true:
			heartUIFull.rect_size.x = hearts * 7.5
			first_set_hearts = false
		else:
			if set_hearts_num % 2 == 0:
				heartUIFull.rect_size.x -= 8
			if set_hearts_num % 2 == 1:
				heartUIFull.rect_size.x -= 7
		set_hearts_num += 1

func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = max_hearts * 7.5

func _ready():
	self.max_hearts = PlayerStats.max_health
	hearts = PlayerStats.health
	PlayerStats.connect("health_changed", self, "set_hearts")
	PlayerStats.connect("max_health_changed", self, "set_max_hearts")
