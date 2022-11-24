extends CharacterBody2D

@export var ACCELETATION = 500
@export var MAX_SPEED = 80
@export var FRICTION = 500

enum {
	MOVE,
	ATTACK
}

var state = MOVE
var Velocity = Vector2.ZERO
var stats = PlayerStats

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
#@onready var swordHitbox = $HitboxPivot/SwordHitbox
@onready var shoot = $Marker2D

var projectile = preload ("res://Player/Projectil.tscn")

func _ready():
	stats.no_health.connect(queue_free)
	animationTree.active = true
	
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
			
		ATTACK:
			attack_state(delta)
	
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")	
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		#swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELETATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		animationState.travel("Idle")
	
	move()
	
	if Input.is_action_just_pressed("attack"):
		#state = ATTACK
		var newProjectile = projectile.instantiate()
		newProjectile.position = shoot.global_position
		newProjectile.set_direction(velocity.normalized())
		get_tree().current_scene.add_child(newProjectile)
		

func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func move():
	move_and_slide()
	
	
func attack_animation_finished():
	state = MOVE


func _on_hurtbox_area_entered(area):
	stats.health -=1
	pass # Replace with function body.
