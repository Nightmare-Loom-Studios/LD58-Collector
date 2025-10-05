extends Node3D

func _ready():
    UnoWorld.ROOT.delay(
        func():
        UnoWorld.GAME.time = null
        UnoWorld.CAMERA.HUD.get_node('Vacuum').text = ''
        UnoWorld.CAMERA.HUD.get_node('Timer').text = ''
        UnoWorld.CAMERA.HUD.get_node('Day').text = 'End of day '+str(Game.day)
        UnoWorld.CAMERA.HUD.emit_signal('add_money', 0)
        , .1
    )
