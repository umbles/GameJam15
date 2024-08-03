extends CharacterBody3D

@onready var camera_h = $CameraPivot/h
@onready var mesh_pivot = $Pivot

@export var speed = 18;
@export var gravity = 70
@export var jump_height = 25

var h_velocity = Vector3.ZERO
var v_velocity = 0

var direction = -Vector3.FORWARD
var acceleration = 6
var angular_acceleration = 7

func _on_focus_changed(control:Control) -> void:
	if control != null:
		print(control.name)

func _ready():
	get_viewport().connect("gui_focus_changed", _on_focus_changed)

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit();

func _physics_process(delta):
	var h_rotation: float = camera_h.global_transform.basis.get_euler().y

	#var forward = Vector3.FORWARD
	direction = Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0,
		Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")).rotated(Vector3.UP, h_rotation).normalized()

	$Debug/Direction.text = "direction: " + str(direction)
	
	var previous_direction = direction if direction != Vector3.ZERO else direction

	
	velocity = lerp(velocity, direction * speed, delta * acceleration)
		
	# Vertical Velocity
	if not is_on_floor():
		v_velocity = v_velocity - gravity * delta	
	# Jumping
	elif Input.is_action_just_pressed("jump"):
		v_velocity = jump_height
	
	velocity.y = v_velocity

	if previous_direction != Vector3.ZERO:
		var current_rotation = lerp_angle(mesh_pivot.rotation.y, atan2(direction.x, direction.z), delta * angular_acceleration)
		
		if mesh_pivot.rotation.y != current_rotation:
			mesh_pivot.rotation.y = current_rotation


	move_and_slide()
	
