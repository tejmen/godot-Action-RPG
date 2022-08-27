extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

var invincible = false setget set_invincible

onready var timer = $Timer

signal invinciblitiy_started
signal invinciblitiy_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invinciblitiy_started")
	else:
		emit_signal("invinciblitiy_ended")

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)
	

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position 


func _on_Timer_timeout():
	self.invincible = false

func _on_HurtBox_invinciblitiy_started():
	set_deferred("monitoring",false)

func _on_HurtBox_invinciblitiy_ended():
	monitoring = true
