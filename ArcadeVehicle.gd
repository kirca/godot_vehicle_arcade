extends RigidBody


func _physics_process(delta):
	var position_node = $MeshInstance.get_global_transform()
	var can_accelerate = $RearLeft.is_colliding() or $RearRight.is_colliding()
	var can_turn = $FrontLeft.is_colliding() or $FrontRight.is_colliding()
	if Input.is_action_pressed("ui_up") and can_accelerate:
		add_central_force(position_node.basis[2].normalized() * 30 * mass)
	if Input.is_action_pressed("ui_down") and can_accelerate:
		add_central_force(position_node.basis[2].normalized() * -10 * mass)
	if Input.is_action_pressed("ui_left") and can_turn:
		add_torque(Vector3(0, 4, 0) * mass)
	if Input.is_action_pressed("ui_right") and can_turn:
		add_torque(Vector3(0, -4, 0) * mass)
	if Input.is_action_pressed("ui_select"):
		add_central_force(Vector3(0, 30, 0) * mass)
