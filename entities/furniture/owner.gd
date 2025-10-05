extends StaticBody3D

func _process(delta: float) -> void:
    $AnimatedSprite3D.flip_h = UnoWorld.PLAYER.global_position.x < global_position.x 