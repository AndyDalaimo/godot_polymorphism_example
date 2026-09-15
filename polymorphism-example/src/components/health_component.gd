class_name HealthComponent
extends Node

@export var parent: Node

@export var max_health: float = 25.0
var health: float = max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _reduce_health(value: float) -> void:
	health -= value
	if health <= 0:
		_death()

func _death() -> void:
	if parent:
		## TODO - Add any flourishes before freeing the parent node 
		parent.queue_free()
