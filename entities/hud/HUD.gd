extends CanvasLayer

signal add_money

func _ready() -> void:
    add_money.connect(_addMoney)

func _addMoney(val) -> void:
    UnoTween.new()\
        .setTrans(Tween.TRANS_CUBIC)\
        .method(func(val): $Money.text = str(round(val*100)/100).pad_decimals(2) + '$', UnoWorld.GAME.money, UnoWorld.GAME.money+val, 1)

    UnoWorld.GAME.money += val
