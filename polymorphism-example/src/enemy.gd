class_name Enemy
extends RigidBody3D

@onready var enemy_collision: Area3D = $EnemyCollision
@onready var mesh: MeshInstance3D = %MeshInstance3D

## Components
@export var health_comp: HealthComponent

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
		if health_comp:
			health_comp._reduce_health(body.damage_comp._on_damage())
	if body is SpecialBall: ## TESTING
		print("This is a Special Ball doing damage")
		
