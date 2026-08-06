class_name Ball
extends RigidBody3D

enum BALL_TYPE {DEFAULT, TYPE1, TYPE2}

@export var ball_type: BALL_TYPE

func _init_ball(_type: BALL_TYPE) -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


## Base Abstract function that will be overridden by child classes
func _shoot(loc: Vector2, impulse_str: float) -> void:
	var imp_direction = global_position.direction_to(Vector3(loc.x, 0.0, loc.y))
	var impulse = imp_direction * impulse_str
	print("FInal IMp: ", impulse)
	apply_central_impulse(impulse)
