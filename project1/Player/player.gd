extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -460.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim=get_node("animationPlayer");
 

func _physics_process(delta):
#	for i in get_slide_collision_count():
#		var collision = get_slide_collision(i)
#		print("Collided with: ", collision.get_collider().name)
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play('jump')
		
	if(velocity.y>0):
		anim.play('fall')
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	var animSprite=get_node("AnimatedSprite2D")
	if(direction==-1):
		animSprite.flip_h=true
	elif(direction==1):
		animSprite.flip_h=false
		
	if direction:
		velocity.x = direction * SPEED
		if(velocity.y==0):
			anim.play('run')
	else:
		velocity.x = move_toward(velocity.x,0, SPEED/15)
		if(velocity.y==0):
			anim.play('idle')
	move_and_slide()
