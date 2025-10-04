extends Area3D

func _ready() -> void:
    body_entered.connect(_onBodyEntered)

func _onBodyEntered(body: Node3D) -> void:
    if body.is_in_group('gatherable'):
        body.emit_signal('gathered')