extends CanvasLayer

var shakeTween: UnoTween
func _input(event: InputEvent) -> void:
    if not visible: return

    if event.is_action_pressed('yes') and not $Sheet1/FakedAmount.visible:
        $Hint.text = ""
        $Sheet1/Amount/Dash.visible = true
        shake(6)
        $Sheet1/FakedAmount.text =  '$'+str(int(Game.dayAmount))
        $Sheet1/FakedAmount.visible = true
        UnoWorld.ROOT.delay(
            func(): $Hint.text = "Press J to start the day"
            , 1
        )
    if event.is_action_pressed('yes') and $Hint.text != '' and $Sheet1/FakedAmount.visible:
        UnoWorld.CAMERA.fadeOut().callback(
            func():
                Engine.time_scale = 0;
                UnoWorld.ROOT.add_child(load('res://game/scenes/level_house.tscn').instantiate())
                Engine.time_scale = 1;
                UnoWorld.GAME.time = null
                visible = false
                UnoWorld.CAMERA.HUD.visible = true
                UnoWorld.CAMERA.fadeIn()
        )

func showIt() -> void:
    $Hint.text = "Press J to falsify"
    $Sheet1/Amount.text = '$'+str(int(Game.dayAmount/100))
    $Day.text = "Seizure of day "+str(Game.day)
    visible = true

func shake(iterations) -> void:
    if shakeTween: return

    var amplitude = UnoCamera.SHAKE_AMPL_WIDE*2
    var speed = UnoCamera.SHAKE_SPEED_QUICK

    if iterations > 1:
        shakeTween = UnoTween.new()\
            .property(self, 'offset:x', randf_range(amplitude*0.5, amplitude)*(-1 if randi_range(0, 1) == 0 else 1)*1.25, speed)\
            .parallel().property(self, 'offset:y', randf_range(amplitude*0.5, amplitude)*(-1 if randi_range(0, 1) == 0 else 1), speed)\
            .callback(func(): shakeTween = null; shake(iterations-1))
    else:
        shakeTween = UnoTween.new()\
            .property(self, 'offset:x', 0, speed)\
            .parallel().property(self, 'offset:y', 0, speed)\
            .callback(func(): shakeTween = null; offset.x = 0; offset.y = 0)
