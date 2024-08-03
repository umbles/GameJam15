extends CharacterBody3D

@export var speed = 18;
@export var fall_acceleration = 75
@export var jump_impulse = 20

var target_velocity = Vector3.ZERO
var direction = Vector3.FORWARD

@onready var cameraPivot = $CameraPivot
@onready var debugLabel = get_node("CameraPivot/DebugLabel")

func _physics_process(delta):
	#var forward = Vector3.FORWARD
	var direction = Vector3(
		Input.get_action_strength("move_left") - Input.get_action_strength("move_right"),
		0,
		Input.get_action_strength("move_forward") - Input.get_action_strength("move_back") )
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	if direction != Vector3.ZERO:
		# Normalise the movement vector
		direction = direction.normalized()
		if cameraPivot:
			var cameraRotation = cameraPivot.transform.basis
			direction = direction * cameraRotation
		direction.y = 0
		# Point the model in the direction of movement
		$Pivot.basis = Basis.looking_at(direction)
		
		
	if debugLabel:
		debugLabel.set_text(str(direction))
	
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	# Vertical Velocity
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	# Jumping
	elif Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
	
	velocity = target_velocity
	
	move_and_slide()
	
