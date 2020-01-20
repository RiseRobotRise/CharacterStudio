extends Tabs

var type : String = ""
var node_name  : String = ""
var idx : int = 0
onready var Stimulus = $MainSplitter/Panel/DropDowns/stimulus.get_popup()
onready var Customs = $MainSplitter/Panel/DropDowns/custom.get_popup()
onready var Actions = $MainSplitter/Panel/DropDowns/actions.get_popup()
onready var Inhibitors = $MainSplitter/Panel/DropDowns/inhibitors.get_popup()
onready var Misc = $MainSplitter/Panel/DropDowns/misc.get_popup()

func _ready() -> void:

	Stimulus.connect("index_pressed",self,"_on_Stimulus_selected")
	Customs.connect("index_pressed",self,"_on_Customs_selected")
	Actions.connect("index_pressed",self,"_on_Actions_selected")
	Inhibitors.connect("index_pressed",self, "_on_Inhibitions_selected")
	Misc.connect("index_pressed",self, "_on_Misc_selected")
	_generate_nodes()

func _on_Stimulus_selected(index) -> void:
	node_name = Stimulus.get_item_text(index)
	_update_labels("stimulus")
	
func _on_Customs_selected(index) -> void:
	node_name = Customs.get_item_text(index)
	_update_labels("custom")
	
func _on_Actions_selected(index) -> void:
	node_name = Actions.get_item_text(index)
	_update_labels("actions")
	
func _on_Inhibitions_selected(index) -> void:
	node_name = Inhibitors.get_item_text(index)
	_update_labels("inhibitors")
	
func _on_Misc_selected(index) -> void:
	node_name = Misc.get_item_text(index)
	_update_labels("misc")
	
func _update_labels(name : String) -> void:
	type = name
	var Placeholder = Nodes.Graphs.get(name).get(node_name).instance()
	$MainSplitter/ViewMenuSplit/Container/selection/name.text = str(Placeholder.title)
	$MainSplitter/ViewMenuSplit/Container/type/name
	
	Placeholder.queue_free()

func _generate_nodes() -> void:
	for Any in Nodes.Graphs:
		var subdict = Nodes.Graphs.get(Any)
		for N in subdict:
			get_node("MainSplitter/Panel/DropDowns/"+Any).get_popup().add_item(N)
		

func _on_Add_node_pressed() -> void:
	if (type == "" or node_name == ""):
		return
	var instanced = Nodes.Graphs.get(type).get(node_name).instance()
	instanced.name = instanced.title + str(idx)
	$MainSplitter/ViewMenuSplit/GraphEdit.add_child(instanced)
	idx+=1

func _on_GraphEdit_connection_request(from, from_slot, to, to_slot) -> void:
	if from != to:
		if not $MainSplitter/ViewMenuSplit/GraphEdit.is_slot_occupied(to_slot, to):
			$MainSplitter/ViewMenuSplit/GraphEdit.connect_node(from, from_slot, to, to_slot)
			


func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot) -> void:
	$MainSplitter/ViewMenuSplit/GraphEdit.disconnect_node(from, from_slot, to, to_slot )
