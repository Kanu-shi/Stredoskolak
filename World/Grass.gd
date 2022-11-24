extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func create_grass_effect():
		var grassEffect = GrassEffect.instantiate()
		get_parent().add_child(grassEffect)
		grassEffect.global_position = global_position

func _on_hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
	area.queue_free()
