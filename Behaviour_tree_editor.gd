extends Tabs

var type : int
var indx  : int
var idx : int = 0

var customs
var store = [Nodes.stimulus,Nodes.inhibitors,Nodes.actions,Nodes.misc, customs]

func _ready():
	var Stimulus = $VSplitContainer/Panel/HBoxContainer/Stimulus.get_popup()
	var Customs = $VSplitContainer/Panel/HBoxContainer/Custom.get_popup()
	var Actions = $VSplitContainer/Panel/HBoxContainer/Actions.get_popup()
	var Behave = $VSplitContainer/Panel/HBoxContainer/Inhibitions.get_popup()
	var Misc = $VSplitContainer/Panel/HBoxContainer/Misc.get_popup()
	Stimulus.connect("index_pressed",self,"_on_Stimulus_selected")
	Customs.connect("index_pressed",self,"_on_Inhibitors_selected")
	Actions.connect("index_pressed",self,"_on_Actions_selected")
	Behave.connect("index_pressed",self, "_on_Inhibitions_selected")
	Misc.connect("index_pressed",self, "_on_Misc_selected")

func _on_Stimulus_selected(index):
	type = 0
	indx = index
	update_labels()
	
func _on_Customs_selected(index):
	type = 3
	indx = index
	update_labels()
	
func _on_Actions_selected(index):
	type = 2
	indx = index
	update_labels()
	
func _on_Inhibitions_selected(index):
	type = 1
	indx = index
	update_labels()
	
func _on_Misc_selected(index):
	type = 3
	indx = index
	update_labels()
	
func update_labels():
	var Placeholder = store[type][indx].instance()
	$VSplitContainer/HSplitContainer/VSplitContainer/VBoxContainer/selection/name.text = str(Placeholder.title)
	$VSplitContainer/HSplitContainer/VSplitContainer/VBoxContainer/type/name
	Placeholder.queue_free()

func _on_Add_node_pressed():
	var instanced = store[type][indx].instance()
	instanced.name = instanced.title + str(idx)
	$VSplitContainer/HSplitContainer/GraphEdit.add_child(instanced)
	idx+=1

func _on_GraphEdit_connection_request(from, from_slot, to, to_slot):
	if from != to:
		if not $VSplitContainer/HSplitContainer/GraphEdit.is_slot_occupied(to_slot, to):
			$VSplitContainer/HSplitContainer/GraphEdit.connect_node(from, from_slot, to, to_slot)


func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot):
	$VSplitContainer/HSplitContainer/GraphEdit.disconnect_node(from, from_slot, to, to_slot )
