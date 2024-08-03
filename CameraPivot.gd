extends Node3D

var h_rotation: float = 0;
var v_rotation: float = 0;

var v_max = 85
var v_min = 2

var h_sensitivity = 0.1
var v_sensitivity = 0.1

var h_acceleration: float = 10
var v_acceleration: float = 10

@onready var camera_node = $h/v/PlayerCamera
@onready var h_node = $h
@onready var v_node = $h/v

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		h_rotation += -event.relative.x * h_sensitivity
		v_rotation += -event.relative.y * v_sensitivity

func _physics_process(delta):
	v_rotation = clamp(v_rotation, -v_max, -v_min)

	h_node.rotation_degrees.y = lerp(h_node.rotation_degrees.y, h_rotation, delta * h_acceleration)
	v_node.rotation_degrees.x = lerp(v_node.rotation_degrees.x, v_rotation, delta * v_acceleration)

