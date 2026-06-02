class_name player extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var isFlipped = false

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Adds Animations
	if abs(velocity.x) > 1:
		animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "default"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _process(_delta: float) -> void:
	# Flips the charcter vertically depending on where it's moving
	if Input.is_action_just_pressed("move_left") and not isFlipped:
		animated_sprite_2d.flip_h = true  # Flip the sprite when left arrow is pressed
		isFlipped = true  # Set the flip state to true
		GlobalVar.Is_player_flipped = true
	if Input.is_action_just_pressed("move_right") and isFlipped:
		animated_sprite_2d.flip_h = false  # Unflip the sprite when right arrow is pressed
		isFlipped = false  # Set the flip state to false
		GlobalVar.Is_player_flipped = false
