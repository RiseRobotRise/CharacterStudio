extends Node

class_name NPCBase

onready var actor = get_parent()

var ai_script : ConfigFile = ConfigFile.new()

export(String, FILE, "*.jbt") var AI_file : String = "" #This works just fine! :D

func convert_to_code(name : String) -> String:
	return ""
	pass
	
func emit_signal_from_port(signals : Array, port : int) -> void:
	if not signals.size() >= port:
		return
	if signals[port]!=null:
		emit_signal(signals[port])

func get_variable_from_port(variables : Array, port : int):
	if not port >= variables.size():
		return
	return variables[port]

func load_script():
	ai_script.load(AI_file)
	for signals in ai_script.get_section_keys("node_signals"):
		add_user_signal(signals)
	for connection in ai_script.get_value("ai_config", "connections", []):
		define_connection(connection.get("from"),
			connection.get("from_port"),
			connection.get("to"), 
			connection.get("to_port"))
		
func define_connection(from : String, from_port : String , to: String, to_port : String):
	#The only information passed from signal to
	var signal_name = from+"_output_"+from_port
	var connection_bindings : Array = []
	#add the signals related to this node to the bindings
	connection_bindings.append(ai_script.get_value("node_signals", to, []))
	connection_bindings.append(ai_script.get_value("variables", to, []))
	var function = to 
	#This section ahead cleans up the node name to get the function name instead
	function = function.replace("@", "")
	for number in range (0, 9):
		function = function.replace(str(number), "")
	#name cleaned up
	connect(signal_name, self, function, connection_bindings) 
	pass
