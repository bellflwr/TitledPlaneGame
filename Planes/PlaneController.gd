extends Node3D

@onready var cp_y: Node3D = $CameraPivotYaw
@onready var cp_p: Node3D = $CameraPivotYaw/CameraPivotPitch
@onready var plane: Node3D = $Sparrow

var look_sensetivity = 0.01

@export var speed: float = 150
@export var pitch_speed: float = 1
@export var roll_speed: float = 1
@export var yaw_speed: float = 1

@export var smoothing: float = 0.3
@export var deadzone: float = 0.05

var pitch = 0
var roll = 0
var yaw = 0


func get_axis(delta, orig, pos_action, neg_action):
	var target = 0
	
	if Input.is_action_pressed(pos_action):
		target += 1
	if Input.is_action_pressed(neg_action):
		target -= 1
		
	if target < orig:
		orig -= delta / smoothing
	elif target > orig:
		orig += delta / smoothing
		
	orig = clamp(orig, -1, 1)	
	if target == 0 and orig < deadzone and orig > -deadzone:
		orig = 0
		
	return orig

func _physics_process(delta):
	pitch = get_axis(delta, pitch, "pitch_up", "pitch_down")
	roll = get_axis(delta, roll, "roll_left", "roll_right")
	yaw = get_axis(delta, yaw, "yaw_left", "yaw_right")

	plane.rotate_object_local(Vector3.FORWARD, -1 * delta * pitch)
	plane.rotate_object_local(Vector3.RIGHT, -1 * delta * roll)
	plane.rotate_object_local(Vector3.UP, 1 * delta * yaw)
	
	translate(plane.global_transform.basis.x * delta * speed)

	

func _input(event):
	if event is InputEventMouseMotion:
		cp_y.rotate_y(-event.relative.x * look_sensetivity)
		
		cp_p.rotate_z(-event.relative.y * look_sensetivity)
		cp_p.rotation.z = clamp(cp_p.rotation.z, -PI/2, PI/2)
		
