extends KinematicBody2D

var angle = 0
var speed = 0
var depressedSpeed = 0 # Speed when ship is rotating
var rotation_speed = 0.05
const SPEED_MAX = 50
const SPEED_MIN = 0
var speedIncrement = 10
var velocity = Vector2()

func _fixed_process(delta):

	depressedSpeed = speed / 1.3
	var angle = get_rot()


	rotation_speed = 0.03 * speed/SPEED_MAX

	if (Input.is_action_pressed("ui_left")):
		set_rot(get_rot() + rotation_speed)
		velocity.x = depressedSpeed * cos(angle)
		velocity.y = -depressedSpeed * sin(angle)

	elif (Input.is_action_pressed("ui_right")):
		set_rot(get_rot() - rotation_speed)
		velocity.x = depressedSpeed * cos(angle)
		velocity.y = -depressedSpeed * sin(angle)
	else:
		velocity.x = speed * cos(angle)
		velocity.y = -speed * sin(angle)


	var motion = velocity * delta
	motion = move(motion)

	if (is_colliding()):
			var n = get_collision_normal()
			motion = n.slide(motion)
			velocity = n.slide(velocity)
			move(motion)


func accelerate():
	print("Accelerate!")
	if (speed < SPEED_MAX):
		speed += speedIncrement

func deccelerate():
	print("Deccelerate")
	if (speed > SPEED_MIN):
		speed -= speedIncrement

func _input(event):
	print("Event!")
	if (event.is_action_pressed("ui_up")):
		accelerate()
	elif (event.is_action_pressed("ui_down")):
		deccelerate()

func _ready():
	print("Player Script Ready!")
	set_fixed_process(true)
	set_process_input(true)
