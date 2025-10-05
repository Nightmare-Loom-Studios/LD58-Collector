extends Node3D
class_name Game

static var day = 0
static var time = 90 # in seconds
static var money: float = 0
static var targetMoney: int = 12000
static var dayAmount: float = 10
static var itemsSucked: int = 0
static var amountSucked: float = 0

static var bonusSpeedCarry: float = 1
static var bonusSpeed: float = 1
static var bonusTime: float = 1
static var bonusRange: float = 1
static var bonusCapacity: float = 1
static var canGrabCat: bool = false

func _ready() -> void:
    UnoWorld.GAME = self
    UnoWorld.CAMERA.fadeIn()
