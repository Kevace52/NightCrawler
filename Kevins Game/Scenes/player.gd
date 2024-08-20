extends CharacterBody2D


@export var speed = 200
@export var jump_velocity = -300.0
@export var acceleration : float = 15.0
@export var jumps = 1
var can_double_jump := true


enum state {IDLE,RUNNING,JUMPUP,JUMPDOWN,HURT}

var anim_state = state.IDLE

@onready var animator = $AnimatedSprite2D 
@onready var animation_player = $AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
 


func update_state():
	if anim_state == state.HURT:
		return
	if is_on_floor():
		if velocity == Vector2.ZERO:
			anim_state = state.IDLE
		elif velocity.x != 0:
			anim_state = state.RUNNING
	else:
		if velocity.x < 0 :
			anim_state = state.JUMPUP
		else:
			anim_state = state.JUMPDOWN


func update_animation(direction):
	if direction > 0 :
		animator.flip_h = false
	elif direction < 0 :
		animator.flip_h = true 
	match anim_state:
		state.IDLE:
			animation_player.play("Idle")
		state.RUNNING:
			animation_player.play("Run")
		state.JUMPUP:
			animation_player.play("Jump_up") 
		state.JUMPDOWN:
			animation_player.play("Jump_down")
		state.HURT:
			animation_player.play("Hurt" )


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		can_double_jump = true


	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():  
			velocity.y = -abs(jump_velocity)
		else:
			if can_double_jump:
				velocity.y = -abs(jump_velocity)
				can_double_jump = false






	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x,direction * speed,acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration/2)



	update_state()
	update_animation(direction)
	move_and_slide()

func _on_area_2d_body_entered(body):
	get_tree().reload_current_scene()
