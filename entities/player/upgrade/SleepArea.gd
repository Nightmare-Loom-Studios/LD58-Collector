extends Node3D

var inside = false;

func _ready() -> void:
    get_node('Area2D').body_entered.connect(_onBodyEntered)
    get_node('Area2D').body_exited.connect(_onBodyExited)

func _input(event) -> void:
    if inside and event.is_action_pressed('yes'):
        UnoWorld.CAMERA.fadeOut().callback(
            func():
                for node in UnoWorld.ROOT.get_children(): node.queue_free()
                UnoWorld.CAMERA.HUD.visible = false
                Game.day += 1
                Game.dayAmount = randi_range(80, 300) * 1000
                UnoWorld.CAMERA.get_node('Falsify').showIt()
                UnoWorld.CAMERA.fadeIn()
        )

func _onBodyEntered(body: Node3D) -> void:
    if body.name == 'UnoPlayer':
        UnoWorld.CAMERA.HUD.get_node('UpgradeBg').visible = true
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = 'Ready for another day of great work ?'
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = 'Sleep to the next day. (Press E)'
        inside = true

func _onBodyExited(body: Node3D) -> void:
    if body.name == 'UnoPlayer':
        UnoWorld.CAMERA.HUD.get_node('UpgradeBg').visible = false
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = ''
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = ''
        inside = false
