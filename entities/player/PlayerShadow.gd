extends Sprite3D

@onready var baseDistance = get_parent().global_position.distance_to(position)

func _process(_delta: float) -> void:
    var query = PhysicsRayQueryParameters3D.create(get_parent().global_position, get_parent().global_position + Vector3.DOWN * 10)

    var result = get_world_3d().direct_space_state.intersect_ray(query)
    if result:
        scale = Vector3.ONE / max((get_parent().global_position.distance_to(result.position) - baseDistance) * .4, 1)
        global_position = result.position + Vector3.UP*.1
