extends AnimatedSprite3D

var animSide: String = 'front'

func _process(delta: float) -> void:     
    if UnoWorld.PLAYER.inputDir.x > 0:
        flip_h = false
        UnoWorld.PLAYER.get_node('Hands').flip_h = false
    elif UnoWorld.PLAYER.inputDir.x < 0:
        flip_h = true
        UnoWorld.PLAYER.get_node('Hands').flip_h = true
    
    if UnoWorld.PLAYER.inputDir.y < 0:
        animSide = 'back'
        UnoWorld.PLAYER.get_node('Hands').position.z = -1
    elif UnoWorld.PLAYER.inputDir.y > 0:
        animSide = 'front'
        UnoWorld.PLAYER.get_node('Hands').position.z = 1
        
    if UnoWorld.PLAYER.inputDir == Vector2.ZERO:
        play('idle'+animSide)
    else:
        play('walk'+animSide)