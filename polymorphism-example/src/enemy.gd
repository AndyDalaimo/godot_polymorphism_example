class_name Enemy
extends MeshInstance3D

@export var health: float = 25.0

@onready var enemy_collision: Area3D = $EnemyCollision

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_enemy_collision_body_entered(body: Node3D) -> void:
	if body is Ball:
		print("DO DAMAGE")
		_damage(body.damage)

func _damage(value: float) -> void:
	health -= value
	if health <= 0.0:
		queue_free()
