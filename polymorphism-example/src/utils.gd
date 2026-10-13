extends Node


enum DAMAGE_TYPE{NONE, POISON, BLEED, LIGHTNING}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN ## Hide mouse Cursor
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
