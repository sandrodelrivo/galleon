extends Node2D

# --- info ---
# quest_loader' receives calls from the game and creates
# an instance of the 'quest' scene. The 'quest' scene script
# has variables to hold all of the quest information for
# later scripting purposes. 

# 'quest_loader' instanced as child of player.

# NOTE: if having a quest scene with the information
# isn't useful for scripting, may switch over to
# having quests stored in a type of array or dictionary.

var quest = load("res://overworld/quest/quest.tscn")
var current_quests = []

func _ready():

	pass

# Accepts the ID of a quest. Creates an instance of it
func create_quest(quest_id):
	
	print("LOADING QUEST... ID: ", quest_id)
	
	var quest_data = {} #Dict that holds the information from the quest JSON file
	
	var file = File.new()
	file.open("res://overworld/quest/quests/" + quest_id + ".json", file.READ)
	var text = file.get_as_text()
	quest_data.parse_json(text)
	file.close()
	current_quests.append(quest_data["id"])
	var quest_instance =  quest.instance()
	quest_instance.set_name(quest_data["id"])
	add_child(quest_instance)
	
	var quest_scene = get_node(quest_data["id"])
	
	quest_scene.quest_data = quest_data
	print(quest_data["start-script"])
	quest_scene.get_node("start_script").set_script(load(quest_data["start-script"]))
	quest_scene.get_node("end_script").set_script(load(quest_data["end-script"]))
	
	quest_scene.get_node("start_script").quest_start()
	#get_node("test").set_text(quest_scene.quest_data["display-name"])

	
	print("QUEST ADDED! ID: ", quest_id)
	
	