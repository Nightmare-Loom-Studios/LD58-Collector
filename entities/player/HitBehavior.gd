extends Node

@onready var parent: UnoPlayer = get_parent()
@export var hitCollidersNode: Node3D
var activeHit: Area3D
var hitTween: UnoTween = null

func _ready() -> void:
    activeHit = hitCollidersNode.get_node('Fist')

func _process(_delta: float) -> void:
    if (UnoWorld.PLAYER.lookTowards != Vector3.ZERO):
        hitCollidersNode.look_at(
            Vector3(
                parent.global_position.x+UnoWorld.PLAYER.lookTowards.x,
                parent.global_position.y,
                parent.global_position.z+UnoWorld.PLAYER.lookTowards.z,
            )
        )

func _input(event) -> void:
    if not hitTween and event.is_action_pressed('hit') and ['idle'].has(UnoWorld.PLAYER.get_node('Hands').animation):
        activeHit.get_node('Sprite3D').modulate.a = 1
        hitTween = UnoTween.new()\
            .property(activeHit.get_node('Sprite3D'), 'modulate:a', 0, .5)\
            .callback(func(): hitTween = null)

        for body in activeHit.get_overlapping_bodies():
            if body.is_in_group('hittable'):
                body.emit_signal('hitted')
