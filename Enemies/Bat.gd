extends CharacterBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

enum {
	IDLE,
	WANDER,
	CHASE
}

@export var ACCELETATION = 3000
@export var MAX_SPEED = 500
@export var FRICTION = 200
@export var KNOCKBACK_CONST = 110

var knockback = Vector2.ZERO
var state = IDLE

@onready var sprite = $AnimatedSprite2d
@onready var stats = $Stats
@onready var playerDetectionZone = $PlayerDetectionZone


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	velocity = knockback
	move_and_slide()
		
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
		WANDER:
			pass
			
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELETATION * delta)
				sprite.flip_h = velocity.x < 0
			else:
				state = IDLE
	
	move_and_slide()


func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func _on_hurtbox_area_entered(area):
	stats.get_damage(area.damage)
	knockback = area.knockback_vector * KNOCKBACK_CONST


func _on_stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
