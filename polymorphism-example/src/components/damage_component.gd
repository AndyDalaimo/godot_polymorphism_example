class_name DamageComponent
extends Node

@export var base_damage: float = 2.5 ## This is the base damage dealt 
@export var damage_type: Utils.DAMAGE_TYPE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_damage() -> float:
	var out_damage = base_damage
	## TODO -> append any 'Special' damage if neccessary. 
	## i.e. Coroutines for damage over time (Poison, Bleed, etc.)
	return out_damage
