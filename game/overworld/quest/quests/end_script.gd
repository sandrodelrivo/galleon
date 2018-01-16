extends Node

func _ready():
	get_owner().get_owner().get_node("test").set_text(get_owner().quest_data["display-name"])