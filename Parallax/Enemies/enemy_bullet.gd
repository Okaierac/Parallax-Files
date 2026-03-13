extends CharacterBody2D

@export var speed := 900
var direction := Vector2.ZERO

func _physics_process(delta):

	velocity = direction * speed
	move_and_slide()


func _on_body_entered(body):

	if body is player_side:
		body._on_penemy_knight_damage()

	queue_free()
