class_name Player
extends CharacterBody3D

@export var balls: Array[Ball]
@export var camera: Camera3D
@export var impulse_strength: float = 10.0

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const RAY_LENGTH = 1000

var current_ball_index: int = 0


@onready var reticle: MeshInstance3D = %Reticle


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot"):
		if current_ball_index >= balls.size():
			current_ball_index = 0
		balls[current_ball_index]._shoot(Vector2(reticle.position.x, reticle.position.z), impulse_strength)
		current_ball_index = current_ball_index + 1
		print("curr ball ", current_ball_index)
	#if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		#var from = camera.project_ray_origin(event.position)
		#var to = from + camera.project_ray_normal(event.position) * RAY_LENGTH
		#var query = PhysicsRayQueryParameters3D.create(from, to)
		#query.collide_with_areas = true
		#var result = get_world_3d().direct_space_state.intersect_ray(query)
		#reticle.position = result["position"]


func _physics_process(_delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	
	var mouse_pos = get_viewport().get_mouse_position()
	
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.collide_with_areas = true
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	if result:
		reticle.position = result["position"]

	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
