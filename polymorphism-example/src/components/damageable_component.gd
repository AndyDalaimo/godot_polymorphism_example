class_name DamageableComponent
extends Node

@export var health_component: HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_collision_area_body_entered(body: Node3D) -> void:
	if body is Ball:
		print("DO DAMAGE on ", get_parent().name)
		if health_component.duplicate():
			health_component._reduce_health(body.damage_comp._on_damage())
	if body is SpecialBall: ## TESTING
		print("This is a Special Ball doing damage")
