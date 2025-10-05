extends Node

signal carried
signal uncarried
signal sell

@onready var parent: PhysicsBody3D = get_parent()
var isCarried: bool = false
var originalCollisionlayer = 0

static var audioLight = preload('res://game/audio/PaySmall.wav')
static var audioMedium = preload('res://game/audio/PayAverage.wav')
static var audioHeavy = preload('res://game/audio/PayBig.wav')
static var sellParticule = preload('res://game/entities/earn_area/dollar_particles.scn')

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
        var sellNode = sellParticule.instantiate()
        UnoWorld.ROOT.add_child(sellNode)
        sellNode.amount = clamp(25 * value/100, 5, 50)
        sellNode.emitting = true
        sellNode.global_position = parent.global_position
        sellNode.finished.connect(func(): sellNode.queue_free())

        UnoTween.new()\
            .property(parent, 'scale', Vector3.ONE*.01, 1)\
            .callback(func(): parent.queue_free())

        UnoCamera.HUD.emit_signal('add_money', value)
        if value >= 600:
            UnoAudio.playSound(audioHeavy, sellNode, 200)
        elif value >= 100:
            UnoAudio.playSound(audioMedium, sellNode, 200)
        else:
            UnoAudio.playSound(audioLight, sellNode, 200)
        parent.remove_from_group('carriable')
