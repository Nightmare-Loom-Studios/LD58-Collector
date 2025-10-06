extends Node3D

func _ready():
    UnoWorld.ROOT.delay(
        func():
        Game.time = null
        Game.itemsSucked = 0
        Game.amountSucked = 0
        UnoWorld.CAMERA.HUD.get_node('Vacuum').text = ''
        UnoWorld.CAMERA.HUD.get_node('Timer').text = ''
        UnoWorld.CAMERA.HUD.get_node('Day').text = 'End of day '+str(Game.day)
        UnoWorld.CAMERA.HUD.emit_signal('add_money', 0)
        , .1
    )
