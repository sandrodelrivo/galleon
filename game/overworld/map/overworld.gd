extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var QuestLoader = get_node("player/quest_loader")
	get_node("get-quest").connect("pressed", QuestLoader, "create_quest", ["test_quest"])
