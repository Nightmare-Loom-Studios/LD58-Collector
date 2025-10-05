extends Area3D

var itemSound = [preload('res://game/audio/FallHard1.wav'), preload('res://game/audio/FallHard2.wav')]
var playerSound = [preload('res://game/audio/FallPlayer1.wav'), preload('res://game/audio/FallPlayer2.wav')]


func _ready() -> void:
    body_entered.connect(_onBodyEntered)


func _onBodyEntered(body: Node3D) -> void:
    if body is CharacterBody3D:
        if body.velocity.length() > 30:
            UnoAudio.playSound(playerSound.pick_random(), body)
    elif body is not StaticBody3D:
        if body.linear_velocity.length() > 30:
            UnoAudio.playSound(itemSound.pick_random(), body)
