extends Node2D

var projectile = preload ("res://Player/Projectil.tscn")

#var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	var newProjectile = projectile.instantiate()
	newProjectile.position = Vector2(-10, randf_range(0, 600))
	get_tree().current_scene.add_child(newProjectile)
