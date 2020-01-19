extends Node

const VECTOR = Color(0.5,0.2,0.2,1)
const INT = Color(0.8,0.3,1,1)
const BOOL = Color(1,1,1,1)
const FLOAT = Color(0,1,0,1)
const ARRAY = Color(0.7,0.2,0.0,1.0)
const NIL = Color(0,0,0,1)

var Graphs : Dictionary = {
	"actions" : {
		"Go to" : preload("res://Nodes/Actions/Go_to.tscn"), 
		"Shoot" : preload("res://Nodes/Actions/Shoot.tscn"),
		"Flee" : preload("res://Nodes/Actions/Flee.tscn"),
		"Play sound" : preload("res://Nodes/Actions/Play_sound.tscn")
	},
	
	"stimulus" : {
		"Got Shot" : preload("res://Nodes/Stimulus/Got Shot.tscn"),
		"Enemy on sight" : preload("res://Nodes/Stimulus/Enemy on sight.tscn"),
		"Hear" : preload("res://Nodes/Stimulus/Hear.tscn"),
		"Visuals" : preload("res://Nodes/Stimulus/Visuals.tscn"),
		"Smell" : preload("res://Nodes/Stimulus/Smell.tscn")
	},
	
	"inhibitors" : {
		"Decision" : preload("res://Nodes/Inhibitors/Decision.tscn"), 
		"Preservation" : preload("res://Nodes/Inhibitors/Preservation.tscn")
	},
	"misc" : { 
		"Math" : preload("res://Nodes/Misc/Math.tscn"),
		"Parallel trigger" : preload("res://Nodes/Misc/Parallel Trigger.tscn")
	},
	"custom" :  {}
}

func _ready():
	load_user_defined_nodes()
	print(Graphs)

func load_user_defined_nodes():
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
	

