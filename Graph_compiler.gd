extends GraphEdit

var SceneNodes : Dictionary
var Currently_selected : Node = null
func _ready():
	connect("node_selected", self, "_on_node_selected")

func add_node(name : String):
	var REGEX : RegEx = RegEx.new()
	REGEX.compile(".[A-Za-z]*[\\s*[A-Za-z]*]*[^0-9]")
	var Result : Array = REGEX.search_all(name)
	if Result == null:
		print("No matches, names don't match the RegEx")
		return
	if Result.size() > 0:
		print("Theres a result")
		if Nodes.Graphs.inhibitors.has(Result[0].get_string()):
			SceneNodes[name]=Nodes.Graphs.inhibitors.get(Result[0].get_string()).instance()
			return
		if Nodes.Graphs.custom.has(Result[0].get_string()):
			SceneNodes[name]=Nodes.Graphs.custom.get(Result[0].get_string()).instance()
			return
		if Nodes.Graphs.stimulus.has(Result[0].get_string()):
			SceneNodes[name]=Nodes.Graphs.stimulus.get(Result[0].get_string()).instance()
			return
		if Nodes.Graphs.misc.has(Result[0].get_string()):
			return
			SceneNodes[name]=Nodes.Graphs.misc.get(Result[0].get_string()).instance()
		if Nodes.Graphs.actions.has(Result[0].get_string()):
			SceneNodes[name]=Nodes.Graphs.actions.get(Result[0].get_string()).instance()
			return
		else:
			print("Non-existant node ",Result[0].get_string() ,", check your Character Studio version, if this is a custom node, please use only letters and spaces for the title")
	
func _input(event):
	if event is InputEventKey:
		if Input.is_action_pressed("Shift") and Input.is_key_pressed(KEY_A):
			$Behaviors.rect_position = get_tree().get_root().get_mouse_position()
			$Behaviors.popup()
		if Input.is_key_pressed(KEY_DELETE) and Currently_selected != null:
			var all_connections : Array = get_connection_list()
			for connection in all_connections:
				var from_port = connection.get("from_port")
				var from = connection.get("from")
				var to_port = connection.get("to_port")
				var to = connection.get("to")
				if (Currently_selected.name == from or Currently_selected.name == to):
					disconnect_node(from,from_port,to,to_port)
			if is_instance_valid(Currently_selected):
				Currently_selected.clear_all_slots()
				Currently_selected.queue_free()
				update()
			
func compile(Connections):
	#Check data types, translate into signals and code. 
	open(Connections)
	for elements in Connections:
		var from_port = elements.get("from_port")
		var from = elements.get("from")
		var to_port = elements.get("to_port")
		var to = elements.get("to")
		var to_node = get_node(to)
		var from_node = get_node(from)
		to_node.content[to_port]
		from_node.content[from_port]
		var function = "call_deferred("
	pass


func open(SaveArray : Array):
	for connection in SaveArray:
		if not SceneNodes.has(connection.from):
			add_node(connection.from)
		if not SceneNodes.has(connection.to):
			add_node(connection.to)

func _on_node_selected(node):
	Currently_selected = node

func _on_Button3_pressed():
	print(open(get_connection_list()))
	pass # Replace with function body.

func is_slot_occupied(to_port, to):
	for connection in get_connection_list():
		var from_port = connection.get("from_port")
		var from = connection.get("from")
		if is_node_connected(from, from_port, to, to_port ):
			return true

func _on_GraphEdit_connection_request(from, from_slot, to, to_slot) -> void:
	print("Requesting conection from node: ", from, " port: ", from_slot, " to node: ", to, " port: ", to_slot)
	if from != to:
		if not is_slot_occupied(to_slot, to):
			connect_node(from, from_slot, to, to_slot)
			


func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot) -> void:
	disconnect_node(from, from_slot, to, to_slot )



func _on_GraphEdit_node_selected(node : GraphNode):
	print(node.get_slot_type_right(0), ", ",  node.get_slot_type_left(0))
	pass # Replace with function body.
