extends Node3D

func _ready():
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
