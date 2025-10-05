extends Node

@onready var parent: UnoPlayer = get_parent()
@export var hitCollidersNode: Node3D
var activeHit: Area3D
var hitTween: UnoTween = null

var soundHit = [preload('res://game/audio/Frappe1.wav'), preload('res://game/audio/Frappe2.wav'), preload('res://game/audio/Frappe3.wav')]
var soundHitOk = [preload('res://game/audio/HitOk1.wav'), preload('res://game/audio/HitOk2.wav'), preload('res://game/audio/HitOk3.wav')]

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

        var hasHit = false
        for body in activeHit.get_overlapping_bodies():
            if body.is_in_group('hittable'):
                body.emit_signal('hitted')
                hasHit = true

        if hasHit:
            UnoAudio.playSound(soundHit.pick_random(), parent, 80)
        else:
            UnoAudio.playSound(soundHitOk.pick_random(), parent, 1000)
