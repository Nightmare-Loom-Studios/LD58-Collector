extends Node3D

@export var trash1: Node3D
@export var trash2: Node3D
@export var trash3: Node3D
@export var trash4: Node3D

@export var tableLiving: Node3D

@export var drawer1: Node3D
@export var drawer2: Node3D

@export var tv: Node3D
@export var tv_flat: Node3D

@export var fridge1: Node3D
@export var fridge2: Node3D
@export var fridge3: Node3D

@export var kitchenTable1: Node3D
@export var kitchenTable2: Node3D
@export var kitchenDrawer: Node3D

@export var wardrobe1: Node3D
@export var wardrobe2: Node3D

@export var shelf1: Node3D
@export var shelf2: Node3D

@export var bed: Node3D
@export var tableBedroom1: Node3D
@export var tableBedroom2: Node3D
@export var carpetBedroom: Node3D
@export var wardrobeBedroom: Node3D
@export var tableBedroom: Node3D
@export var drawerbedroom1: Node3D
@export var drawerbedroom2: Node3D

@export var owner1: Node3D
@export var owner2: Node3D
@export var owner3: Node3D

func _ready():
    randomize()
    UnoWorld.ROOT.delay(
        func():
        UnoWorld.GAME.time = 90*Game.bonusTime
        UnoWorld.CAMERA.HUD.get_node('UpgradeBg').visible = false
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = ''
        UnoWorld.CAMERA.HUD.get_node('Day').text = ''
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = ''
        UnoWorld.CAMERA.HUD.emit_signal('reset_vacuum')
        , .1
    )

    if randi_range(0, 100) > 80: trash1.queue_free()
    if randi_range(0, 100) > 80: trash2.queue_free()
    if randi_range(0, 100) > 80: trash3.queue_free()
    if randi_range(0, 100) > 80: trash4.queue_free()

    if randi_range(0, 100) > 50: drawer1.queue_free()
    else: drawer2.queue_free()

    if randi_range(0, 100) > 50: tv.queue_free()
    else: tv_flat.queue_free()

    if randi_range(0, 100) > 80: fridge1.queue_free()
    if randi_range(0, 100) > 40: fridge2.queue_free()
    if randi_range(0, 100) > 40: fridge3.queue_free()

    if randi_range(0, 100) > 50: kitchenTable1.queue_free()
    else: kitchenTable2.queue_free()

    if randi_range(0, 100) > 30: kitchenDrawer.queue_free()

    if randi_range(0, 100) > 40: wardrobe1.queue_free()
    if randi_range(0, 100) > 40: wardrobe2.queue_free()
    else: shelf1.queue_free()

    if randi_range(0, 100) > 20: shelf2.queue_free()
    if randi_range(0, 100) > 40: bed.rotation_degrees.y = 0
    else: bed.rotation_degrees.y = -90

    if randi_range(0, 100) > 50: tableLiving.rotation_degrees.y = 0
    else: tableLiving.rotation_degrees.y = -90

    if randi_range(0, 100) > 25: tableLiving.get_node('Chair').queue_free()
    elif randi_range(0, 100) > 25: tableLiving.get_node('Chair4').queue_free()

    if randi_range(0, 100) > 40: tableBedroom1.queue_free()
    elif randi_range(0, 100) > 40: tableBedroom2.queue_free()

    if randi_range(0, 100) > 40: carpetBedroom.queue_free()

    if randi_range(0, 100) > 40: drawerbedroom1.queue_free()
    if randi_range(0, 100) > 40: drawerbedroom2.queue_free()

    if randi_range(0, 100) > 50: wardrobeBedroom.queue_free()
    else: tableBedroom.queue_free()

    if randi_range(0, 100) > 33: owner1.queue_free()
    elif randi_range(0, 100) > 33: owner2.queue_free()
    else: owner3.queue_free()
