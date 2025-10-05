extends CanvasLayer

signal add_money
signal add_vacuum
signal reset_vacuum

func _ready() -> void:
    add_money.connect(_addMoney)
    add_vacuum.connect(_addVacuum)
    reset_vacuum.connect(_resetVacuum)

func _process(delta: float) -> void:
    if Input.is_action_pressed('wow'):
        UnoWorld.GAME.time = 1

    if UnoWorld.GAME.time != null:
        if UnoWorld.GAME.time < 0:
            UnoWorld.CAMERA.fadeOut().callback(
                func():
                    Engine.time_scale = 0;
                    for node in UnoWorld.ROOT.get_children():
                        node.queue_free()
                    if Game.money >= Game.targetMoney:
                         get_tree().change_scene_to_packed(load('res://game/world/ending.scn'))
                    else:
                        UnoWorld.ROOT.add_child(load('res://game/scenes/level_safe.tscn').instantiate())
                    Engine.time_scale = 1;
                    UnoWorld.CAMERA.fadeIn()
            )
            UnoWorld.GAME.time = null
        else:
            UnoWorld.GAME.time -= delta
            $Timer.text = str(int(UnoWorld.GAME.time/60)) + ':' + str(int(fmod(UnoWorld.GAME.time, 60))).pad_zeros(2)

func _addMoney(val) -> void:
    UnoTween.new()\
        .setTrans(Tween.TRANS_CUBIC)\
        .method(func(val): $Money.text = '$'+str(int(val))+' /$'+str(Game.targetMoney), UnoWorld.GAME.money, UnoWorld.GAME.money+val, 1)

    UnoWorld.GAME.money += val

func _addVacuum(val) -> void:
    var frac = (UnoWorld.GAME.itemsSucked+val)/(Vacuum.MAX_ITEMS*Game.bonusCapacity)
    UnoTween.new()\
        .setTrans(Tween.TRANS_CUBIC)\
        .method(func(val): $Vacuum.text = str(val)+'/'+str(int(Vacuum.MAX_ITEMS*Game.bonusCapacity)), UnoWorld.GAME.itemsSucked, UnoWorld.GAME.itemsSucked+val, .5)\
        .parallel().property($Vacuum, 'label_settings:font_color', Color.RED if frac == 1 else Color(1, 1-frac*.75, 1-frac*.5), .5)\
        .callback(func(): $Vacuum.text = str(UnoWorld.GAME.itemsSucked)+'/'+str(int(Vacuum.MAX_ITEMS*Game.bonusCapacity)))

    UnoWorld.GAME.itemsSucked += val
    if frac >= 1:
        $Vacuum/Hint.visible = true

func _resetVacuum() -> void:
    UnoTween.new()\
        .setTrans(Tween.TRANS_CUBIC)\
        .method(func(val): $Vacuum.text = str(val)+'/'+str(int(Vacuum.MAX_ITEMS*Game.bonusCapacity)), UnoWorld.GAME.itemsSucked, 0, .25)\
        .parallel().property($Vacuum, 'label_settings:font_color', Color.WHITE, .1)\
        .callback(func(): $Vacuum.text = str(UnoWorld.GAME.itemsSucked)+'/'+str(int(Vacuum.MAX_ITEMS*Game.bonusCapacity)))

    UnoWorld.GAME.amountSucked = 0
    UnoWorld.GAME.itemsSucked = 0
    $Vacuum/Hint.visible = false
