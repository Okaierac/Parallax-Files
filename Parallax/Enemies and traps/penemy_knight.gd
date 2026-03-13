extends CharacterBody2D

@export var bullet_scene: PackedScene
@onready var shoot_timer: Timer = $ShootTimer
@onready var shoot_point: Marker2D = $Marker2D
@onready var penemy_knight: CharacterBody2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

var hp = 5
var speed = 300.0
var player_detected = false
var player_chase = false
var on_action = false
var shoot_range = 900

signal damage
signal killed
signal dead

func _ready():
	animated_sprite_2d.animation = "alive"

func _on_penemy_fly_player_seen() -> void:
	if not on_action:
		position = Vector2(2450, 318500)
		on_action = true
	player_detected = true

func _physics_process(delta: float) -> void:
	
	#health system
	if hp == 0:
		player_detected = false
		animated_sprite_2d.animation = "dead"
		killed.emit()
	elif hp < 0:
		#hp = 5
		#player_detected = true
		animated_sprite_2d.animation = "alive"
	
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Detect When Player is in Shooting Range
	if player_detected:
		var player = $"../Player_Side"
		var distance = position.distance_to(player.position)
		if distance > shoot_range:
			# Chase player
			var direction = (player.position - position).normalized()
			velocity.x = direction.x * speed
		else:
			# Stop moving and shoot
			velocity.x = 0
		move_and_slide()

	# Flip sprite direction based on velocity.x
	if velocity.x > 0:
		animated_sprite_2d.flip_h = true  # Moving right, no flip
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = false   # Moving left, flip


func _on_area_2d_body_entered(body: Node2D) -> void:
	damage.emit()


func _on_player_side_attack() -> void:
	hp -= 1
	animated_sprite_2d.animation = "hurt"
	timer.start()


func _on_timer_timeout() -> void:
	if hp > 0:
		animated_sprite_2d.animation = "alive"

func _on_killed() -> void:
	print("Enemy1 died at ", global_position)  # Debug print to check the location
	GlobalVar.enemy_location = global_position  # Store the enemy's position
	dead.emit()
	print(GlobalVar.enemy_location)
	queue_free() 

func shoot():
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = shoot_point.global_position
	var player = $"../Player_Side"
	bullet.direction = (player.global_position - bullet.global_position).normalized()

func _on_shoot_timer_timeout() -> void:
	if player_detected and hp > 0:
		shoot()
