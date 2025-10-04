extends StaticBody3D

signal hitted

@export var hitPoints: int = 1
@export var minValue: float = 10
@export var maxValue: float = 50

const money: Dictionary[int, PackedScene] = {
    50: preload('res://game/entities/valuables/light/CoinGold.scn'),
    10: preload('res://game/entities/valuables/light/CoinSilver.scn')
}

func _ready() -> void:
    add_to_group('hittable')
    hitted.connect(_onHitted)

func _onHitted() -> void:
    UnoWorld.CAMERA.shake(UnoCamera.SHAKE_AMPL_TIGHT, UnoCamera.SHAKE_SPEED_QUICK, 2)
    UnoWorld.CAMERA.HUD.emit_signal('add_money', randf_range(minValue, maxValue))

    hitPoints -= 1
    get_node('AnimatedSprite3D').play(str(hitPoints))
    if hitPoints <= 0:
        spawnMoney()
        remove_from_group('hittable')

func spawnMoney():
    for i in range(0, 10):
        var newNode = money.values().pick_random().instantiate()
        UnoWorld.ROOT.add_child(newNode)
        newNode.position = global_position + Vector3(randf_range(-10,10), 2, 5)
        newNode.linear_velocity.y = randf_range(10, 50)
        newNode.linear_velocity.x = randf_range(-10, 10)
        newNode.linear_velocity.z = randf_range(2, 20)
