extends Node

signal carried
signal uncarried

@onready var parent: Node3D = get_parent()
var isCarried: bool = false

func _ready() -> void:
    parent.add_to_group('carriable')    

    carried.connect(_onCarried)
    uncarried.connect(_onUncarried)
    
func _process(delta: float) -> void:
    if not isCarried: return
    
    parent.position = UnoWorld.PLAYER.global_position + Vector3(0, 18, 0)
    
func _onCarried() -> void:
    isCarried = true
    
func _onUncarried() -> void:
    isCarried = false