extends Node3D

@export var price = 200
@export var text: String
@export var fulltext: String

var inside = false;

func _ready() -> void:
    get_node('Area2D').body_entered.connect(_onBodyEntered)
    get_node('Area2D').body_exited.connect(_onBodyExited)
    
    match name:
        'UpgradeSlowedCarry': if Game.bonusSpeedCarry > 1: queue_free()
        'UpgradeSpeed': if Game.bonusSpeed > 1: queue_free()
        'UpgradeTime': if Game.bonusTime > 1: queue_free()
        'UpgradeAnimal': if Game.canGrabCat: queue_free()
        'UpgradeRange': if Game.bonusRange > 1: queue_free()
        'UpgradeCapacity': if Game.bonusCapacity > 1: queue_free()

func _input(event) -> void:
    if inside and (event.is_action_pressed('yes')):
        UnoWorld.CAMERA.HUD.emit_signal('add_money', -price)
        match name:
            'UpgradeSlowedCarry': Game.bonusSpeedCarry = 1.2
            'UpgradeSpeed': Game.bonusSpeed = 1.2
            'UpgradeTime': Game.bonusTime = 1.5
            'UpgradeAnimal': Game.canGrabCat = true
            'UpgradeRange': Game.bonusRange = 1.5
            'UpgradeCapacity': Game.bonusCapacity = 2
        queue_free()

func _onBodyEntered(body: Node3D) -> void:
    if body.name == 'UnoPlayer':
        UnoWorld.CAMERA.HUD.get_node('UpgradeBg').visible = true
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = fulltext
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = str(price) + '$ - ' + text
        if Game.money >= price:
            UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = UnoWorld.CAMERA.HUD.get_node('UpgradeText').text + '   (Press J  to buy)'
        else:
            UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = UnoWorld.CAMERA.HUD.get_node('UpgradeText').text + '   (Not enough)'
        inside = true

func _onBodyExited(body: Node3D) -> void:
    if body.name == 'UnoPlayer':
        UnoWorld.CAMERA.HUD.get_node('UpgradeBg').visible = false
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = ''
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = ''
        inside = false
