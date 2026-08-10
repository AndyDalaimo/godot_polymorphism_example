class_name Ball
extends RigidBody3D

signal reset_ball(index: int)

enum BALL_TYPE {DEFAULT, TYPE1, TYPE2}

@export var ball_type: BALL_TYPE

var can_shoot: bool = true
var inventory_index: int = 0

func _init_ball(_type: BALL_TYPE) -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if linear_velocity.length() < 12.0 and linear_velocity.length() > 5.0 and !can_shoot:
		reset_ball.emit(inventory_index)
	pass

## Base SHOOT function that will be inherited by child classes
func _shoot(start_loc: Vector3, loc: Vector2, impulse_str: float) -> void:
	visible = true
	global_position = start_loc
	var imp_direction = global_position.direction_to(Vector3(loc.x, 0.0, loc.y))
	var impulse = imp_direction * impulse_str
	apply_central_impulse(impulse)

func _reset(loc: Vector3) -> void:
	visible = false
	set_can_shoot(true)
	linear_velocity = Vector3.ZERO
	global_position = loc

func get_can_shoot() -> bool:
	return can_shoot

func set_can_shoot(value: bool) -> void:
	can_shoot = value
