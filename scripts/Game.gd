extends Node3D

var time = 360 # in seconds
var money: float = 0
var itemsSucked: int = 0
var amountSucked: float = 0

func _ready() -> void:
    UnoWorld.GAME = self