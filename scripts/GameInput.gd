extends Node

func _ready() -> void:
    UnoInput.addInput('move_forward', KEY_W)
    UnoInput.addInput('move_left', KEY_A)
    UnoInput.addInput('move_backward', KEY_S)
    UnoInput.addInput('move_right', KEY_D)
    UnoInput.addInput('jump', KEY_SPACE)
    UnoInput.addInput('hit', KEY_J)
    UnoInput.addInput('suck', KEY_U)
    UnoInput.addInput('empty_bag', KEY_I)
    UnoInput.addInput('grab', KEY_K)