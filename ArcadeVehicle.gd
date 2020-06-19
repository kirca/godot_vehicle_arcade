extends RigidBody

const GRIP := 50


func _physics_process(delta):
	var position_node = $MeshInstance.get_global_transform()
	var can_accelerate = $RearLeft.is_colliding() or $RearRight.is_colliding()
	var can_turn = $FrontLeft.is_colliding() or $FrontRight.is_colliding()
	if Input.is_action_pressed("ui_up") and can_accelerate:
		add_central_force(position_node.basis[2].normalized() * 10 * mass)
	if Input.is_action_pressed("ui_down") and can_accelerate:
		add_central_force(position_node.basis[2].normalized() * -10 * mass)
	if Input.is_action_pressed("ui_left") and can_turn:
		add_torque(Vector3(0, 4, 0) * mass)
	if Input.is_action_pressed("ui_right") and can_turn:
		add_torque(Vector3(0, -4, 0) * mass)
	if Input.is_action_pressed("ui_select"):
		add_central_force(Vector3(0, 30, 0) * mass)
	var speed = linear_velocity.length()
	if speed > 1:
		var side_dir = position_node.basis[0].normalized()
		var steer_angle = rad2deg(acos(side_dir.dot(linear_velocity.normalized())))
		var force = Vector3(0, 0, 0)
		if steer_angle < 90:
			force = side_dir * -speed * GRIP
		elif steer_angle > 90:
			force = side_dir * speed * GRIP
		add_central_force(force)
