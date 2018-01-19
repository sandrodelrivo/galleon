extends TileMap

onready var anim = get_node("anim")

func _process(delta):

	if (not anim.is_playing()):
		anim.play("coast_bottom")

func _ready():

	set_process(true)
