class_name player_topdown extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite_2d: Sprite2D = $Sprite2D
var move_speed : float = 400.0
var isFlipped = false  # Keep track of the flip state

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( delta ):
	
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity = direction * move_speed
	
	if Input.is_action_just_pressed("left") and not isFlipped:
		animated_sprite_2d.flip_h = true  # Flip the sprite when left arrow is pressed
		isFlipped = true  # Set the flip state to true
	elif Input.is_action_just_pressed("right") and isFlipped:
		animated_sprite_2d.flip_h = false  # Unflip the sprite when right arrow is pressed
		isFlipped = false  # Set the flip state to false



func _physics_process( delta ):
	move_and_slide()
	
	if abs(velocity.x) or abs(velocity.y) > 1:
		animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "default"
