extends Node

signal carried
signal uncarried
signal sell

@onready var parent: Node3D = get_parent()
var isCarried: bool = false

func _ready() -> void:
    parent.add_to_group('carriable')

    carried.connect(_onCarried)
    uncarried.connect(_onUncarried)
    sell.connect(_onSell)

func _process(delta: float) -> void:
    if not isCarried: return

    parent.position = UnoWorld.PLAYER.global_position + Vector3(0, 18, 0)

func _onCarried() -> void:
    isCarried = true

func _onUncarried() -> void:
    isCarried = false
    UnoWorld.ROOT.delay(
        func():
            parent.position = UnoWorld.PLAYER.global_position + Vector3(0, 10, 15),
        .1
    )


func _onSell() -> void:
    if not isCarried:
        UnoTween.new()\
            .property(parent, 'scale', Vector3.ONE*.01, 1)\
            .callback(func(): parent.queue_free())

        UnoCamera.HUD.emit_signal('add_money', 30)
        parent.remove_from_group('carriable')