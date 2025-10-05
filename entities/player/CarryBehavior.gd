extends Node

@onready var parent: UnoPlayer = get_parent()
var closestNode: Node3D = null
var carriedNode: NodeSlot

func _ready() -> void:
    carriedNode = NodeSlot.new(
        func(node: Node3D): node.get_node('CarriableBehavior').emit_signal('carried'); UnoWorld.PLAYER.get_node('Hands').play('carry'),
        func(node: Node3D): node.get_node('CarriableBehavior').emit_signal('uncarried'); UnoWorld.PLAYER.get_node('Hands').play('idle')
    )

func _input(event: InputEvent) -> void:
    if event.is_action_pressed('grab') and ['idle', 'carry'].has(UnoWorld.PLAYER.get_node('Hands').animation):
        if carriedNode.node: carriedNode.put(null)
        elif closestNode: carriedNode.put(closestNode)

func _process(delta: float) -> void:
    UnoWorld.PLAYER.MVT_MAX_SPEED = 30*UnoWorld.GAME.bonusSpeed if carriedNode.node == null else 20*UnoWorld.GAME.bonusSpeedCarry
    if carriedNode.node != null: return

    for node: Node3D in parent.get_tree().get_nodes_in_group('carriable'):
        if node.global_position.distance_to(parent.global_position) <= 17:
            closestNode = node
            return

    closestNode = null
