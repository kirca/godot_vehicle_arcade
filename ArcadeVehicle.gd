extends RigidBody


func _physics_process(delta):
	if Input.is_action_pressed("ui_accept"):
		apply_central_impulse(Vector3(0, 1, 0))
