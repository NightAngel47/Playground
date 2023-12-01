class_name Player
extends CharacterBody2D

signal player_died()

@export var speed = 150.0
@export var jump_velocity = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
		$AnimatedSprite2D.flip_h = direction >= 0
		$Camera2D.drag_horizontal_offset = direction
		$AnimatedSprite2D.play()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		$AnimatedSprite2D.pause()

	move_and_slide()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	player_died.emit()
	queue_free() #destroy player when off screen, probably want something better
	
#HACK move quit function elsewhere, 
#just here for quicker debugging until proper menu flow
func _input(event):
	if event.is_action("ui_cancel"):
		get_tree().quit()
