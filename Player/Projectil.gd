extends "res://Overlap/Hitbox.gd"

@export var speed = 200

@onready var stred = $Stred

var angle = PI/3

var direction = Vector2(1,0): set = set_direction

func _physics_process(delta):
	position += direction * speed * delta
	position = stred.global_position + (position - stred.global_position).rotated(angle)
	


func set_direction(value):
	direction = value
