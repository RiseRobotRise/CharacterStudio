extends GraphEdit

var SceneNodes : Dictionary
var Currently_selected : Node = null
func _ready():
	connect("node_selected", self, "_on_node_selected")

func add_node(name : String):
	var REGEX : RegEx = RegEx.new()
	REGEX.compile("[A-Za-z]")
	var Result : RegExMatch =REGEX.search(name)
	if Result.strings.size() > 0:
		if Result.strings[0] in Nodes.inhibitors:
			pass
		SceneNodes[name]="res://"+Result.strings[0]
	
func _input(event):
	if event is InputEventKey:
		if Input.is_action_pressed("Shift") and Input.is_key_pressed(KEY_A):
			$MainMenu.rect_position = get_tree().get_root().get_mouse_position()
			$MainMenu.popup()
		if Input.is_key_pressed(KEY_DELETE) and Currently_selected != null:
			var all_connections : Array = get_connection_list()
			for connection in all_connections:
				var from_port = connection.get("from_port")
				var from = connection.get("from")
				var to_port = connection.get("to_port")
				var to = connection.get("to")
				if (Currently_selected.name == from or Currently_selected.name == to):
					disconnect_node(from,from_port,to,to_port)
			Currently_selected.clear_all_slots()
			Currently_selected.queue_free()
			update()
			
func compile(Connections):
	#Check data types, translate into signals and code. 
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
		if not Nodes.has(connection.from):
			Nodes.append(connection.from)
		if not Nodes.has(connection.to):
			Nodes.append(connection.to)

func _on_node_selected(node):
	Currently_selected = node

func _on_Button3_pressed():
	print(get_connection_list())
	pass # Replace with function body.

func is_slot_occupied(to_port, to):
	for connection in get_connection_list():
		var from_port = connection.get("from_port")
		var from = connection.get("from")
		if is_node_connected(from, from_port, to, to_port ):
			return true

	