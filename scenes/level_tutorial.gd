extends Node3D

func _ready():
    UnoWorld.ROOT.delay(func():
        UnoWorld.GAME.time = null
        UnoWorld.CAMERA.HUD.get_node('Timer').text = ''
        UnoWorld.CAMERA.HUD.get_node('Control').visible = false
        UnoWorld.CAMERA.HUD.get_node('Vacuum').position.y = 200
        UnoWorld.CAMERA.HUD.get_node('UpgradeBg').visible = true
        , .1
    )

func _process(delta: float) -> void:
    var pos = UnoWorld.PLAYER.global_position.x
    if pos < 25:
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = 'Use WASD to move and SPACE to jump.'
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = 'How to move'
    elif pos < 75:
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = 'Get as much money as possible. You have limited time each day.'
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = 'Goal'
    elif pos < 150:
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = 'Hold SHIFT to vacuum valuable stuff nearby.'
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = 'Retrieve precious items'
    elif pos < 200:
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = 'Press J to empty your bag. (Keep it with you)'
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = 'Limited vacuum space'
    elif pos < 275:
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = 'Press E to throw the item you carry. Throw it on this area so it can be sold.'
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = 'How to sell items'
    elif pos < 325:
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = 'Press E to grab an item and start carring it. You can sell it too.'
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = 'How to grab items'
    elif pos < 375:
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = 'Press H to give a hit. Attack some items several times to get whats inside !'
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = 'How to hit furnitures'
    elif pos < 400:
        UnoWorld.CAMERA.HUD.get_node('UpgradeTextFull').text = 'Go to the right to start playing.'
        UnoWorld.CAMERA.HUD.get_node('UpgradeText').text = 'Lets start !'
    else:
        UnoWorld.CAMERA.fadeOut().callback(
            func():
                Engine.time_scale = 0;
                for node in UnoWorld.ROOT.get_children():
                    node.queue_free()
                UnoWorld.GAME.itemsSucked = 0
                UnoWorld.GAME.amountSucked = 0
                UnoWorld.CAMERA.HUD.get_node('Vacuum').position.y = 266
                UnoWorld.CAMERA.HUD.get_node('Control').visible = true
                UnoWorld.GAME.money = 0
                UnoWorld.CAMERA.HUD.emit_signal('add_money', 0)
                UnoWorld.ROOT.add_child(preload('res://game/scenes/level_safe.tscn').instantiate())
                Engine.time_scale = 1;
                UnoWorld.CAMERA.fadeIn()
        )
