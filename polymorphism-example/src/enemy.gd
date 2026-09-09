class_name Enemy
extends RigidBody3D

@export var health: float = 25.0

@onready var enemy_collision: Area3D = $EnemyCollision
@onready var mesh: MeshInstance3D = %MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	linear_velocity.z = 0.8
	pass

func _on_enemy_collision_body_entered(body: Node3D) -> void:
	if body is Ball:
		print("DO DAMAGE")
		_damage(body.damage)
	if body is SpecialBall:
		print("This is a Special Ball doing damage")
		body.on_deal_damage(self)

func _damage(value: float) -> void:
	health -= value
	if health <= 0.0:
		queue_free()
