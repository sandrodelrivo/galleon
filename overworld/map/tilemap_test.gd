extends TileMap

var time = 0.0
var frame = get_node("tileset").frame


func _ready():
	set_physics_process(true)
	
	pass

func _physics_process(delta):
	time+=delta
	
	if (time>0.2):
		time=0
		frame+=1
		if (frame>3):
			frame=0
			
	
	pass
