extends Node3D
class_name Beginning

var state = 0
var charTimer = 0
var currentText = ''

var quicker = 1
const TIME_BETWEEN_CHARS = .02

func _input(event: InputEvent) -> void:
    if event.is_action_pressed('jump') or event.is_action_pressed('hit'):
        quicker = 5
    if event.is_action_released('jump') or event.is_action_released('hit'):
        quicker = 1

    match state:
        2:
            if event.is_action_pressed('jump'):
                $UnoCamera/CanvasLayer/Text1.visible = false
                $UnoCamera/CanvasLayer/Text2.visible = true
                currentText = $UnoCamera/CanvasLayer/Text2.text;
                $UnoCamera/CanvasLayer/Text2.text = '';
                charTimer = TIME_BETWEEN_CHARS;
                hideLabel($UnoCamera/CanvasLayer/Continue)
                state += 1
        4:
            if event.is_action_pressed('jump'):
                $UnoCamera/CanvasLayer/Text2.visible = false
                $UnoCamera/CanvasLayer/Text3.visible = true
                currentText = $UnoCamera/CanvasLayer/Text3.text;
                $UnoCamera/CanvasLayer/Text3.text = '';
                charTimer = TIME_BETWEEN_CHARS;
                hideLabel($UnoCamera/CanvasLayer/Continue)
                state += 1
        6:
            if event.is_action_pressed('jump'):
                hideLabel($UnoCamera/CanvasLayer/Text3)
                hideLabel($UnoCamera/CanvasLayer/Continue).callback(
                    func():
                        UnoTween.new()\
                        .setTrans(Tween.TRANS_CUBIC)\
                        .property($UnoCamera, 'rotation_degrees:y', -45, 1)\
                        .callback(func(): $UnoCamera.fadeOut().callback(func(): get_tree().change_scene_to_packed(preload('res://game/scenes/game.scn')))))

func _process(delta: float) -> void:
    charTimer -= delta * quicker
    match state:
        0:
            state = -1
            UnoTween.new()\
                    .setTrans(Tween.TRANS_CUBIC)\
                    .property($UnoCamera, 'global_position:z', 10, 1)\
                    .callback(func(): currentText = $UnoCamera/CanvasLayer/Text1.text; $UnoCamera/CanvasLayer/Text1.text = ''; charTimer = TIME_BETWEEN_CHARS; state = 1)
        1:
            if charTimer <= 0:
                $UnoCamera/CanvasLayer/Text1.text += currentText[0]
                $UnoCamera/CanvasLayer/Text1.visible = true
                charTimer = TIME_BETWEEN_CHARS
                currentText = currentText.substr(1)
                if currentText.length() == 0:
                    state = 2
                    showLabel($UnoCamera/CanvasLayer/Continue)
        3:
            if charTimer <= 0:
                $UnoCamera/CanvasLayer/Text2.text += currentText[0]
                charTimer = TIME_BETWEEN_CHARS
                currentText = currentText.substr(1)
                if currentText.length() == 0:
                    state += 1
                    showLabel($UnoCamera/CanvasLayer/Continue)
        5:
            if charTimer <= 0:
                $UnoCamera/CanvasLayer/Text3.text += currentText[0]
                charTimer = TIME_BETWEEN_CHARS
                currentText = currentText.substr(1)
                if currentText.length() == 0:
                    state += 1
                    showLabel($UnoCamera/CanvasLayer/Continue)


func showLabel(node) -> UnoTween:
    return UnoTween.new()\
        .setTrans(Tween.TRANS_CUBIC)\
        .property(node, 'modulate:a', 1, .25)

func hideLabel(node) -> UnoTween:
    return UnoTween.new()\
        .setTrans(Tween.TRANS_CUBIC)\
        .property(node, 'modulate:a', 0, .25)
