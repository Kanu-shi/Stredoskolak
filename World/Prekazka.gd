extends Node2D

@export var health = 4
var hit =1

const DestroyEffect = preload("res://Effects/AsteroidDestroy.tscn")
# Called when the node enters the scene tree for the first time.

@onready var sprite2D = $Sprite2D

func _ready():
	pass # Replace with function body.

func create_destroy_effect():
		var destroyEffect = DestroyEffect.instantiate()
		get_parent().add_child(destroyEffect)
		destroyEffect.global_position = global_position

func _on_hurtbox_area_entered(area):
	sprite2D.set_frame(hit)
	area.queue_free()
	if (hit == health):		
		create_destroy_effect()
		queue_free()		
	hit += 1
