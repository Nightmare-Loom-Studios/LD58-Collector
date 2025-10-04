extends Node

@onready var parent: UnoPlayer = get_parent()
@export var hitCollidersNode: Node3D
var activeHit: Area3D

func _ready() -> void:
    activeHit = hitCollidersNode.get_node('Fist')

func _process(_delta: float) -> void:
    if (parent.inputDir != Vector2.ZERO):
        hitCollidersNode.look_at(hitCollidersNode.global_position+Vector3(parent.inputDir.x, 0, parent.inputDir.y))

func _input(event) -> void:
    if event.is_action_pressed('hit'):
        for body in activeHit.get_overlapping_bodies():
            print(body)
            print(body.is_in_group('hittable'))
            if body.is_in_group('hittable'):
                body.emit_signal('hitted')
