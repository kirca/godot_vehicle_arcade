extends Camera

const DISTANCE := 5
const HEIGHT := 1
onready var vehicle = get_parent()

func _init():
	set_as_toplevel(true)

func _process(delta):
	if not vehicle.active:
		current = false
		return
	current = true
	var target = vehicle.get_global_transform().origin
	var pos = get_global_transform().origin
	var up = Vector3(0, 1, 0)
	var offset = pos - target
	offset = offset.normalized() * DISTANCE
	offset.y = HEIGHT
	pos = target + offset
	look_at_from_position(pos, target, up)
	
