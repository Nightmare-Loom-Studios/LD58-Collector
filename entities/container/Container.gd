extends StaticBody3D

signal hitted

@export var hitPoints: int = 1
@export var valuables: Array[PackedScene] = []
@export var number: int = 1

@onready var sound = [preload('res://game/audio/Tiroir1.ogg'), preload('res://game/audio/Tiroir2.ogg')]

func _ready() -> void:
    add_to_group('hittable')
    hitted.connect(_onHitted)

func _onHitted() -> void:
    UnoWorld.CAMERA.shake(UnoCamera.SHAKE_AMPL_WIDE, UnoCamera.SHAKE_SPEED_QUICK, 2)

    hitPoints -= 1
    hitPoints -= Game.bonusHit
    get_node('AnimatedSprite3D').frame = hitPoints
    if hitPoints < 0:
        get_node('AnimatedSprite3D').queue_free()
        spawnMoney()
        remove_from_group('hittable')

func spawnMoney():
    for i in range(0, number):
        UnoAudio.playSound(sound.pick_random(), self, 10)
        UnoAudio.playSound(preload('res://game/audio/HitBroken.wav'), self, 10)
        var newNode = valuables.pick_random().instantiate()
        UnoWorld.ROOT.get_children()[0].add_child(newNode)
        newNode.position = global_position + Vector3(randf_range(-10,10), 2, 5)
        newNode.linear_velocity.y = randf_range(10, 50)
        newNode.linear_velocity.x = randf_range(-10, 10)
        newNode.linear_velocity.z = randf_range(2, 20)
