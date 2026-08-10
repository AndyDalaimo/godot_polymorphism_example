class_name Player
extends CharacterBody3D

@export_category("Ball Manager")
@export var balls: Array[Ball]
@export var impulse_strength: float = 10.0
@export var autoshoot: bool = false

@export_category("Player Controller")
@export_subgroup("Camera")
@export var camera: Camera3D
@export var reticle: MeshInstance3D
@export_subgroup("Movement")
@export var SPEED: float = 5.0
@export var JUMP_VELOCITY: float = 4.5

const RAY_LENGTH = 1000

var current_ball_index: int = 0
var can_player_shoot: bool = false

@onready var held_shot_timer: Timer = %HeldShotTimer


func _ready() -> void:
	init_ball_setup()

func _input(_event: InputEvent) -> void:
	pass
	#if event.is_action_pressed("Shoot"):
		#shoot_ball()
		#if balls[current_ball_index].get_can_shoot():
			#balls[current_ball_index].set_can_shoot(false)
			#balls[current_ball_index]._shoot(self.global_position, Vector2(reticle.position.x, reticle.position.z), impulse_strength)
			#current_ball_index = current_ball_index + 1
			#if current_ball_index >= balls.size():
				#current_ball_index = 0
			#print("curr ball ", current_ball_index)
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
	if (Input.is_action_pressed("Shoot") and can_player_shoot) or (autoshoot and can_player_shoot):
		shoot_ball()
		can_player_shoot = false
		held_shot_timer.start()
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
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func init_ball_setup() -> void:
	var i = 0
	for b in balls:
		b.inventory_index = i
		b.reset_ball.connect(reset_ball)
		b._reset(self.global_position) ## Set Balls to Player position
		i += 1
	can_player_shoot = true
	

func shoot_ball() -> void:
	for b:Ball in balls:
		if b.get_can_shoot():
			print("Curr Ball: ", b.inventory_index)
			b._shoot(self.position, Vector2(reticle.position.x, reticle.position.z), impulse_strength)
			b.set_can_shoot(false)
			break

func reset_ball(index: int) -> void:
	balls[index]._reset(self.global_position)
	balls[index].set_can_shoot(true)
	current_ball_index = index


func _on_held_shot_timer_timeout() -> void:
	can_player_shoot = true
