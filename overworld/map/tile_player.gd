extends AnimationPlayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	play("ocean_light")
	set_process(true)
	
func _process(delta):
	if not is_playing():
		play("ocean_light")


