extends Node

@onready var parent: Node3D = get_parent()
var isCarried: bool = false

func _input(event) -> void:
    if event.is_action_pressed('hit'):
        print()
