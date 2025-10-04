extends RigidBody3D

@export var value: float = 1;

signal gathered

func _ready() -> void:
    add_to_group('gatherable')
    gathered.connect(_onGathered)

func _onGathered() -> void:
    UnoTween.new()\
        .setTrans(Tween.TRANS_SINE)\
        .parallel().property(self, 'scale', Vector3.ONE*1.1, .1)\
        .parallel().property(self, 'position:y', position.y + 5, .25)\
        .property(self, 'scale', Vector3.ONE*.01, .5)\
        .callback(func(): self.queue_free())


    UnoWorld.GAME.amountSucked += value

    remove_from_group('gatherable')
