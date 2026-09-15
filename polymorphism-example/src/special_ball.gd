class_name SpecialBall
extends Ball

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

## Overridden function from parent class
func _secondary_shoot() -> void:
	print("This is the secondary action for a 'Special Ball'")
	pass

## -------------------------------------------------------------------
## Secondary actions to be overridden by child classes (Special Balls)
## -------------------------------------------------------------------

## Secondary action before the ball is reset back to Player position
func on_reset_action() -> bool:
	return true

### Secondary action after a special ball has dealt base damage to Enemy
#func on_deal_damage(enemy: Enemy) -> void:
	#match (damage_type):
		#Utils.DAMAGE_TYPE.POISON:
			#var material = StandardMaterial3D.new()
			#material.albedo_color = Color(0.253, 0.05, 0.182, 1.0)
			#if !enemy.mesh.get_surface_override_material(0):
				#enemy.mesh.set_surface_override_material(0, material)
			#pass
		#Utils.DAMAGE_TYPE.BLEED:
			#pass
		#Utils.DAMAGE_TYPE.LIGHTNING:
			#pass
