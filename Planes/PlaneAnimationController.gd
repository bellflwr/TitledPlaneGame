extends Node3D



func _ready():
	$PropellerAnimator.play("Propeller", -1, 5.0)


func _process(delta):
	if Input.is_action_just_pressed("pitch_up"):
		$ElevatorAnimator.play("PitchUp")
	if Input.is_action_just_pressed("pitch_down"):
		$ElevatorAnimator.play("PitchDown")
	if Input.is_action_just_released("pitch_up") or Input.is_action_just_released("pitch_down"):
		$ElevatorAnimator.play("PitchReset")
		
	if Input.is_action_just_pressed("roll_left"):
		$AileronAnimator.play("RollLeft")
	if Input.is_action_just_pressed("roll_right"):
		$AileronAnimator.play("RollRight")
	if Input.is_action_just_released("roll_left") or Input.is_action_just_released("roll_right"):
		$AileronAnimator.play("RollReset")
		
	if Input.is_action_just_pressed("yaw_left"):
		$RudderAnimator.play("YawLeft")
	if Input.is_action_just_pressed("yaw_right"):
		$RudderAnimator.play("YawRight")
	if Input.is_action_just_released("yaw_left") or Input.is_action_just_released("yaw_right"):
		$RudderAnimator.play("YawReset")





