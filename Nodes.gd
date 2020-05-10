extends Node

var Definitions = NpcDefinitions.new()
var Colors : Array = [
	Color(0,0,0,1),
	Color(0.2,0,0,1),
	Color(0.2,0.2,0,1),
	Color(0.2,0.2,0.2,1),
	Color(0.2,0.2,0.4,1),
	Color(0.2,0.4,0.4,1),
	Color(0.4,0.4,0.4,1),
	Color(0.4,0,0),
	Color(0.6,0.4,0.4,1),
	Color(0.6,0.6,0.4,1),
	Color(0.6,0.6,0.6,1),
	Color(0.6,0.6,0.8,1),
	Color(0.6,0.8,0.8,1),
	Color(0.8,0.8,0.8,1),
	Color(1,0.8,0.8,1),
	Color(1,1,0.8,1),
	Color(1,1,1,1),
	Color(1,0,1,1),
	Color(1,1,0,1),
	Color(0.5, 0.2, 0.2, 1),
	Color(0.1,0.6,0.1, 1),
	Color(0.6, 0.2, 0.7, 1),
	Color(0.9,0.1,0.9,1),
	Color(0.2,0,0.2,1),
	Color(0.7, 0, 0.5),
	Color(0.5, 0, 0.5),
	Color(0.2, 1, 0.1),
	Color(1,0.5,0.2,1)
	] 

func _enter_tree() -> void:
	_load_definitions()

func _is_format_correct() -> bool:
	if Definitions.get("_functions") == null or Definitions.get("_stimulus") == null:
		return false
	else:
		return true

func _define_class(_class_name : String):
	var current : Dictionary = Definitions.get(_class_name)
	Colors.append(current.color)
	var properies = current.keys()
	
	
func _load_definitions() -> void:
	if not _is_format_correct():
		return
	var all_properties = Definitions.get_property_list()
	var Classes : Array = []
	for properties in all_properties:
		if properties.get("name").begins_with("CLASS_"):
			Classes.append(properties.get("name"))
	#At this point all_properties has been filtered
	



func Color(id) -> Color:
	return Colors[id]


var Graphs : Dictionary = {
	"actions" : {
		"Go to" : preload("res://Nodes/Actions/Go_to.tscn"), 
		"Shoot" : preload("res://Nodes/Actions/Shoot.tscn"),
		"Flee" : preload("res://Nodes/Actions/Flee.tscn"),
		"Play sound" : preload("res://Nodes/Actions/Play_sound.tscn"),
		"Force Next" : preload("res://Nodes/Actions/ForceNext.tscn")
	},
	
	"stimulus" : {
		"Got Shot" : preload("res://Nodes/Stimulus/Got Shot.tscn"),
		"Hear" : preload("res://Nodes/Stimulus/Hear.tscn"),
		"Visuals" : preload("res://Nodes/Stimulus/Visuals.tscn"),
		"Smell" : preload("res://Nodes/Stimulus/Smell.tscn"),
		"Local Input" : preload("res://Nodes/Stimulus/InputLocal.tscn")
	},
	
	"inhibitors" : {
		"Decision" : preload("res://Nodes/Inhibitors/Decision.tscn"), 
		"Preservation" : preload("res://Nodes/Inhibitors/Preservation.tscn")
	},
	"misc" : { 
		"Math" : preload("res://Nodes/Misc/Math.tscn"),
		"Filter" : preload("res://Nodes/Misc/Filter.tscn"),
		"Parallel trigger" : preload("res://Nodes/Misc/Parallel Trigger.tscn")
	},
	"custom" :  {}
}

func _ready() -> void:
	load_user_defined_nodes()

func load_user_defined_nodes() -> void:
	var Dir = Directory.new()
	var CustomNodes : Array = []
	if  not Dir.dir_exists("user://CustomNodes/"):
		Dir.make_dir("user://CustomNodes/")
	Dir.open("user://CustomNodes/")
	Dir.list_dir_begin(true, true)
	var file = Dir.get_next()
	while (file!=""):
		CustomNodes.append(file)
		file = Dir.get_next()
	for N in CustomNodes:
		if N.matchn("*.tscn"):
			N = N.replace(".tscn","")
			Graphs.custom[N]=load(str("user://CustomNodes/",N,".tscn"))
	

