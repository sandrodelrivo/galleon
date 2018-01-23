extends KinematicBody2D

var angle = 0
var speed = 0
var depressed_speed = 0 # Speed when ship is rotating
var rotation_speed = 0.05
var SPEED_MAX = 40
var SPEED_MIN = 0
var speed_increment = 10
var is_crashed = false
var velocity = Vector2()
func _fixed_process(delta):

	depressed_speed = speed * 0.75
	var angle = get_rot()


	rotation_speed = 0.015

	if (Input.is_action_pressed("ui_left")):
		set_rot(get_rot() + rotation_speed)
		velocity.x = depressed_speed * cos(angle)
		velocity.y = -depressed_speed * sin(angle)

	elif (Input.is_action_pressed("ui_right")):
		set_rot(get_rot() - rotation_speed)
		velocity.x = depressed_speed * cos(angle)
		velocity.y = -depressed_speed * sin(angle)
	else:
		velocity.x = speed * cos(angle)
		velocity.y = -speed * sin(angle)


	var motion = velocity * delta
	motion = move(motion)

	if (is_colliding()):
		is_crashed = true
	else:
		is_crashed = false




func accelerate():
	#print("Accelerate!")
	if (speed < SPEED_MAX):
		speed += speed_increment

func deccelerate():
	#print("Deccelerate")
	if (speed > SPEED_MIN):
		speed -= speed_increment

func _input(event):
	if (event.is_action_pressed("ui_up")):
		accelerate()
	elif (event.is_action_pressed("ui_down")):
		deccelerate()

func _ready():
	print("Player Script Ready!")
	set_fixed_process(true)
	set_process_input(true)
