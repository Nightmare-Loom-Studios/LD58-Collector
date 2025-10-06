extends Node

func _ready() -> void:
    UnoInput.addInput('move_forward', KEY_W)
    UnoInput.addJoypadMotionInput('move_forward', JOY_AXIS_LEFT_Y, -1)
    
    UnoInput.addInput('move_left', KEY_A)
    UnoInput.addJoypadMotionInput('move_left', JOY_AXIS_LEFT_X, -1)
    
    UnoInput.addInput('move_backward', KEY_S)
    UnoInput.addJoypadMotionInput('move_backward', JOY_AXIS_LEFT_Y, 1)
    
    UnoInput.addInput('move_right', KEY_D)
    UnoInput.addJoypadMotionInput('move_right', JOY_AXIS_LEFT_X, 1)
    
    UnoInput.addInput('jump', KEY_SPACE)
    UnoInput.addJoypadButtonInput('jump', JOY_BUTTON_A)
    
    UnoInput.addInput('suck', KEY_SHIFT)
    UnoInput.addJoypadMotionInput('suck', JOY_AXIS_TRIGGER_RIGHT, 1)
    
    UnoInput.addInput('hit', KEY_H)
    UnoInput.addJoypadButtonInput('hit', JOY_BUTTON_X)
    
    UnoInput.addInput('empty_bag', KEY_J)
    UnoInput.addJoypadButtonInput('empty_bag', JOY_BUTTON_RIGHT_SHOULDER)
    
    UnoInput.addInput('yes', KEY_E)
    UnoInput.addInput('grab', KEY_E)
    
    UnoInput.addJoypadButtonInput('grab', JOY_BUTTON_Y)
    UnoInput.addJoypadButtonInput('yes', JOY_BUTTON_Y)
