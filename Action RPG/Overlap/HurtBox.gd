extends Area2D

export(bool) var ShowHit = true

const HitEffect = preload("res://Effects/HitEffect.tscn")

func _on_HurtBox_area_entered(area):
	if ShowHit:
		var effect = HitEffect.instance()
		var main = get_tree().current_scene
		main.add_child(effect)
		effect.global_position = global_position 
