extends RayCast

onready var vehicle := get_parent()
onready var wheel := get_node("Wheel")
export var WHEEL_REST_HEIGHT := -0.7

func _physics_process(delta):
	var origin = global_transform.origin
	var collision_point = get_collision_point()
	var collision_normal = get_collision_normal()
	var compression = origin.distance_to(collision_point)
	var force := 0.0
	var compression_rate := 1.0
	if is_colliding():
		compression_rate = compression / cast_to.length()
		force = 600 * clamp(1 - compression_rate, 0, 1)
		force -= 150 * vehicle.linear_velocity.y
		force = force * vehicle.mass * delta
		var force_pos = global_transform.origin - vehicle.global_transform.origin
		vehicle.add_force(force * collision_normal, force_pos)
	if wheel:
		wheel.translation.y = WHEEL_REST_HEIGHT * compression_rate
