extends RigidBody3D

@export var value: float = 1;

signal gathered

func _ready() -> void:
    add_to_group('gatherable')
    gathered.connect(_onGathered)

func _onGathered() -> void:
    UnoTween.new()\
        .parallel().property(self, 'scale', Vector3.ONE*.01, 1)\
        .parallel().property(self, 'position:y', position.y + 5, .5)\
        .callback(func(): self.queue_free())

    UnoCamera.HUD.emit_signal('add_money', value)

    remove_from_group('gatherable')
