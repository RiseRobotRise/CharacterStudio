extends Node
const filter = [
	"sin",
	"cos"
]
onready var actor = get_parent()

export(String, FILE, "*.json") var AI_file : String = "" #This works just fine! :D


func load_script():
	var ai_script = File.new()
	ai_script.open(AI_file)
	var json = JSON.parse(ai_script.get_as_text())
	
func execute_on_player(function_name : String, args : Array):
	if function_name in filter:
		return actor.callv(function_name, args)
	else: 
		return null
func get_code_name(input_string : String):
	var Regular : RegEx = RegEx.new()
	
func define_connection(from, from_port, to, to_port):
	#The only information passed from signal to
#	connect(from+from_port, self, to, )
	pass
