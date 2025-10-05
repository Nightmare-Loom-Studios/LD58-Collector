extends Area3D
class_name Vacuum

static var MAX_ITEMS = 8
var cashbagPrefab: PackedScene = preload('res://game/entities/valuables/heavy/cashbag.scn')

var soundOn = preload('res://game/audio/AspiOn.wav')
var onSoundPlayer: AudioStreamPlayer3D = null
var soundSuck = [preload('res://game/audio/AspiSuck1.wav'), preload('res://game/audio/AspiSuck2.wav'), preload('res://game/audio/AspiSuck3.wav')]
var onSuckPlayer: AudioStreamPlayer3D = null

func _ready() -> void:
    $CollisionShape3D.shape.radius = 8 * Game.bonusRange
    $GPUParticles3D.process_material.emission_sphere_radius = Game.bonusRange

func _input(event: InputEvent) -> void:
    if event.is_action_pressed('empty_bag') and UnoWorld.GAME.amountSucked > 0:
        var cashbagNode = cashbagPrefab.instantiate()
        UnoWorld.ROOT.add_child(cashbagNode)
        cashbagNode.get_node('CarriableBehavior').value = UnoWorld.GAME.amountSucked
        if Game.itemsSucked > Vacuum.MAX_ITEMS*Game.bonusCapacity * 0.8:
            cashbagNode.get_node('cashbag_full').visible = true
        elif Game.itemsSucked > Vacuum.MAX_ITEMS*Game.bonusCapacity * 0.5:
            cashbagNode.get_node('cashbag_mid').visible = true
        else: cashbagNode.get_node('cashbag_small').visible = true
        UnoWorld.PLAYER.get_node('CarryBehavior').carriedNode.put(cashbagNode)
        UnoCamera.HUD.emit_signal('reset_vacuum')

    if event.is_action_released('suck') and ['vacuum'].has(UnoWorld.PLAYER.get_node('Hands').animation):
        UnoWorld.PLAYER.get_node('Hands').play('idle')
        if onSoundPlayer:
            onSoundPlayer.stop()
            onSoundPlayer = null
        UnoWorld.PLAYER.get_node('VaccumArea').get_node('GPUParticles3D').emitting = false

func _process(delta: float) -> void:
    if Input.is_action_pressed('suck') and ['idle', 'vacuum'].has(UnoWorld.PLAYER.get_node('Hands').animation):
        UnoWorld.PLAYER.get_node('Hands').play('vacuum')

        if canSuckAgain(0):
            if not onSoundPlayer:
                onSoundPlayer = UnoAudio.playSound(soundOn, self, 15)
                onSoundPlayer.connect('finished', func(): onSoundPlayer.play())

            UnoWorld.PLAYER.get_node('VaccumArea').get_node('GPUParticles3D').emitting = true
            UnoWorld.CAMERA.shake(UnoCamera.SHAKE_AMPL_MEDIUM, UnoCamera.SHAKE_SPEED_QUICK, 2)
            var suckedCount: int = 0
            for body in get_overlapping_bodies():
                if body.is_in_group('gatherable') and canSuckAgain(suckedCount):
                    suckedCount += 1
                    body.emit_signal('gathered')

                    onSuckPlayer = UnoAudio.playSound(soundSuck.pick_random(), self, 15)
                    onSuckPlayer.connect('finished', func(): onSuckPlayer = null)

            UnoCamera.HUD.emit_signal('add_vacuum', suckedCount) if suckedCount > 0 else null

            if not canSuckAgain(suckedCount):
                UnoWorld.PLAYER.get_node('VaccumArea').get_node('GPUParticles3D').emitting = false
                if onSoundPlayer:
                    onSoundPlayer.stop()
                    onSoundPlayer = null

func canSuckAgain(extra) -> bool:
    return UnoWorld.GAME.itemsSucked+extra < Vacuum.MAX_ITEMS*Game.bonusCapacity
