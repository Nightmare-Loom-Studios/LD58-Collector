extends CanvasLayer

signal add_money
signal add_vacuum
signal reset_vacuum

func _ready() -> void:
    add_money.connect(_addMoney)
    add_vacuum.connect(_addVacuum)
    reset_vacuum.connect(_resetVacuum)

func _addMoney(val) -> void:
    UnoTween.new()\
        .setTrans(Tween.TRANS_CUBIC)\
        .method(func(val): $Money.text = str(round(val*100)/100).pad_decimals(2) + '$', UnoWorld.GAME.money, UnoWorld.GAME.money+val, 1)

    UnoWorld.GAME.money += val

func _addVacuum(val) -> void:
    UnoTween.new()\
        .setTrans(Tween.TRANS_CUBIC)\
        .method(func(val): $Vacuum.text = str(val), UnoWorld.GAME.itemsSucked, UnoWorld.GAME.itemsSucked+val, 1)\
        .callback(func(): $Vacuum.text = str(UnoWorld.GAME.itemsSucked))

    UnoWorld.GAME.itemsSucked += val

func _resetVacuum() -> void:
    UnoTween.new()\
        .setTrans(Tween.TRANS_CUBIC)\
        .method(func(val): $Vacuum.text = str(val), UnoWorld.GAME.itemsSucked, 0, .25)\
        .callback(func(): $Vacuum.text = str(UnoWorld.GAME.itemsSucked))

    UnoWorld.GAME.amountSucked = 0
    UnoWorld.GAME.itemsSucked = 0
