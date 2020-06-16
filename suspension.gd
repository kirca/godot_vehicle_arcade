extends RayCast

onready var vehicle := get_parent()

func _physics_process(delta):
	var origin = global_transform.origin
	var collision_point = get_collision_point()
	var collision_normal = get_collision_normal()
	var compression = origin.distance_to(collision_point)
	var force := 0.0
	var compression_rate := 1.0
	if is_colliding():
		compression_rate = compression / cast_to.length()
		force = 7 * (1 - compression_rate)
		force -= 0.5 * vehicle.linear_velocity.y
		force = force * vehicle.mass
		vehicle.add_force(force * collision_normal, translation)
	$Label.text = "%.2f" % compression_rate
