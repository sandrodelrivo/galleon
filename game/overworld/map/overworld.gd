extends Node2D

onready var navigation = get_node("navigation")

const SPEED = 200.0

var begin = Vector2()
var end = Vector2()
var path = []

func _process(delta):
	if (path.size() > 1):
		var to_walk = delta*SPEED #distance in pixels it can move in one frame
		while(to_walk > 0 and path.size() >= 2):
			var pfrom = path[path.size() - 1] # start?
			var pto = path[path.size() - 2] # end?
			var distance = pfrom.distance_to(pto) # distance between current point and next on array
			if (distance <= to_walk): # if the agent can make it to pfrom in a single movement frame
				path.remove(path.size() - 1) # removes last element in array
				to_walk -= distance
			else: # if the agent can only make it a fraction of the distance
				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/distance)
				 # sets the last element in path to the farthest possible position on the  line between pfrom and pto. (t = to_walk/distance)
				to_walk = 0

		var atpos = path[path.size() - 1] # the last element in the array is the new position that the agent moves to.
		#print("At Position:", atpos)
		get_node("player").set_pos(atpos)
		#print("Player Position:", get_node("player").get_pos())

		if (path.size() < 2):
			path = []
			set_process(false)
	else:
		set_process(false)


# Called by _input() on a mouse click. Generates the path for _proccess(delta)
func _update_path():
	var p = navigation.get_simple_path(begin, end, true)
	path = Array(p) # Vector2array too complex to use, convert to regular array
	path.invert()
	print("Path:", path)

	set_process(true)


func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON and event.pressed and event.button_index == 1):
		begin = get_node("player").get_pos()
		print("Begin:", begin)
		# Mouse to local navigation coordinates
		var click_pos = (event.pos)/2
		var camera_pos = get_node("player").get_node("camera").get_pos()
		end = (click_pos+camera_pos) + get_node("player").get_pos()

		print("----- Click Event -------")
		print("Click Position:", click_pos)
		print("Camera Position:", camera_pos)
		print("End:", end)
		#print("End:", end)
		_update_path()


func _ready():
	print("Overworld Script Ready!")
	set_process_input(true)
