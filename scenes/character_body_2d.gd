extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0

@onready var _animated_sprite = $AnimatedSprite2D

#func _process(_delta):
	#if Input.is_action_pressed("right"):
		#_animated_sprite.play("walk_right")
	#else:
		#_animated_sprite.stop()
		#
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if _animated_sprite.frame == 3:
			_animated_sprite.stop()

	if Input.is_action_just_pressed("jump"):
		print("jump pressed")
	
	# Handle jump.
	if Input.is_action_just_pressed(&"jump") and is_on_floor():
		print("jump")
		velocity.y = JUMP_VELOCITY
		_animated_sprite.play("jump")
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.y == 0.0:
		# check if moving horisontally
		if abs(velocity.x) > 0.0:
			_animated_sprite.play("walk")
		else:
			_animated_sprite.stop()
		
		
	# handle direction 
	if velocity.x > 0.0:
		_animated_sprite.flip_h = false
	elif velocity.x < 0.0:
		_animated_sprite.flip_h = true
		
	move_and_slide()
