class_name CameraController
extends Camera3D

## Value that the Camera FOV is increased / decraesed on Mouse wheel
@export_range(1.0, 10.0, 0.5) var camera_zoom: float 

const MAX_FOV: float = 125.0
const MIN_FOV: float = 80.0

func _input(event):
	if event.is_action_pressed("CameraZoomDown"):
		if fov < MAX_FOV:
			fov += camera_zoom
	if  event.is_action_pressed("CameraZoomUp"):
		if fov > MIN_FOV:
			fov -= camera_zoom

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
