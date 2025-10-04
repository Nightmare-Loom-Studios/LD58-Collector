extends Area3D

var cashbagPrefab: PackedScene = preload('res://game/entities/valuables/heavy/cashbag.scn')

func _input(event: InputEvent) -> void:
    if event.is_action_pressed('empty_bag') and UnoWorld.GAME.amountSucked > 0:
        var cashbagNode = cashbagPrefab.instantiate()
        UnoWorld.ROOT.add_child(cashbagNode)
        cashbagNode.get_node('CarriableBehavior').value = UnoWorld.GAME.amountSucked
        UnoWorld.PLAYER.get_node('CarryBehavior').carriedNode.put(cashbagNode)
        UnoCamera.HUD.emit_signal('reset_vacuum')

func _process(delta: float) -> void:
    if Input.is_action_pressed('suck'):
        UnoWorld.CAMERA.shake(UnoCamera.SHAKE_AMPL_MEDIUM, UnoCamera.SHAKE_SPEED_QUICK, 2)
        var suckedCount: int = 0
        for body in get_overlapping_bodies():
            if body.is_in_group('gatherable'):
                suckedCount += 1
                body.emit_signal('gathered')

        UnoCamera.HUD.emit_signal('add_vacuum', suckedCount) if suckedCount > 0 else null
