extends Node3D

@export var price = 200
@export var text: String
@export var fulltext: String

func _ready() -> void:
    get_node('Area2D').body_entered.connect(_onBodyEntered)
    get_node('Area2D').body_exited.connect(_onBodyExited)

func _onBodyEntered(body: Node3D) -> void:
    if body.name == 'UnoPlayer':
        UnoWorld.CAMERA.HUD.get_node('UpgradeBg').visible = true
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = fulltext
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = str(price) + '$ - ' + text + '   (Press J  to buy)'

func _onBodyExited(body: Node3D) -> void:
    if body.name == 'UnoPlayer':
        UnoWorld.CAMERA.HUD.get_node('UpgradeBg').visible = false
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = ''
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = ''
