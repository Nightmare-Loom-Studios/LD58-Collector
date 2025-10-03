extends Node

@onready var parent: UnoPlayer = get_parent()
var closestNode: Node3D = null
var carriedNode: NodeSlot

func _ready() -> void:
    carriedNode = NodeSlot.new(
        func(node: Node3D): node.get_node('CarriableBehavior').emit_signal('carried'),
        func(node: Node3D): node.get_node('CarriableBehavior').emit_signal('uncarried')
    )

func _input(event: InputEvent) -> void:
    if event.is_action_pressed('grab'):
        if carriedNode.node: carriedNode.put(null)
        elif closestNode: carriedNode.put(closestNode)

func _process(delta: float) -> void:
    if carriedNode.node != null: return

    for node: Node3D in parent.get_tree().get_nodes_in_group('carriable'):
        if node.position.distance_to(parent.position) < 10:
            closestNode = node
            return

    closestNode = null