extends KinematicBody2D

var angle = 0
var speed = 0
var depressed_speed = 0 # Speed when ship is rotating
var rotation_speed = PI/200
var SPEED_MAX = 30
var SPEED_MIN = 0
var speed_increment = 5
var velocity = Vector2()

# note - rotation is in radians, not degrees
func _physics_process(delta):

	depressed_speed = speed * 0.75

	if (Input.is_action_pressed("ui_left")):
		rotate(-1 * rotation_speed)
		velocity.x = depressed_speed * cos(rotation)
		velocity.y = depressed_speed * sin(rotation)

	elif (Input.is_action_pressed("ui_right")):
		rotate(rotation_speed)
		velocity.x = depressed_speed * cos(rotation)
		velocity.y = depressed_speed * sin(rotation)
	else:
		velocity.x = speed * cos(rotation)
		velocity.y = speed * sin(rotation)


	var motion = velocity * delta
	motion = move_and_collide(motion)





func accelerate():
	print("Accelerate!")
	if (speed < SPEED_MAX):
		speed += speed_increment

func deccelerate():
	print("Deccelerate")
	if (speed > SPEED_MIN):
		speed -= speed_increment

func _input(event):
	#print("INPUT!")
	if (event.is_action_pressed("ui_up")):
		accelerate()
	elif (event.is_action_pressed("ui_down")):
		deccelerate()

func _ready():
	print("Player Script Ready!")
	set_physics_process(true)
	set_process_input(true)
