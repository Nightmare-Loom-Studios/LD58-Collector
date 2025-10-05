extends Node

signal carried
signal uncarried
signal sell

@onready var parent: PhysicsBody3D = get_parent()
var isCarried: bool = false
var originalCollisionlayer = 0

@export var value: float = 1;

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
    originalCollisionlayer = parent.collision_layer
    parent.collision_layer = 0

func _onUncarried() -> void:
    isCarried = false
    UnoWorld.ROOT.delay(
        func():
            parent.collision_layer = originalCollisionlayer
            , .1
    )
   
    UnoWorld.CAMERA.shake(UnoCamera.SHAKE_AMPL_MEDIUM, UnoCamera.SHAKE_SPEED_QUICK, 2)
    parent.linear_velocity.y = 10
    parent.linear_velocity.x = UnoWorld.PLAYER.lookTowards.x * 8
    parent.linear_velocity.z = UnoWorld.PLAYER.lookTowards.z * 8

func _onSell() -> void:
    if not isCarried:
        UnoTween.new()\
            .property(parent, 'scale', Vector3.ONE*.01, 1)\
            .callback(func(): parent.queue_free())

        UnoCamera.HUD.emit_signal('add_money', value)
        parent.remove_from_group('carriable')
