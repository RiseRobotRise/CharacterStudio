extends Spatial

"""
Interface/Integrator to connect all signals to a behavior tree and provide its functionality
"""

export(String, FILE, "*.jsm") var NPC_File : String = "" #This works just fine! :D
export(String) var initial_state : String = ""
export(NodePath) var Interactable_Path : NodePath = ""


var BehaviorTree : JxNPC = null
var worker 


func _ready():

	BehaviorTree = JxNPC.new(NPC_File, initial_state)
	BehaviorTree.actor = get_parent()
	BehaviorTree.navigator = get_parent().get_component("NPCInput")
	
	
	#Worker related functions and signals, setup
	BehaviorTree.worker = worker
	BehaviorTree._create_signal("workstation_assigned")
	BehaviorTree._create_signal("stopped_working")
	BehaviorTree._create_signal("request_rejected")
	worker.connect("request_rejected", self, "_on_request_rejected")
	worker.connect("stopped_working", self, "_on_worker_stopped")
	worker.connect("workstation_assigned", self, "_on_worker_assigned")
	
	#Workstation setup
	BehaviorTree._create_signal("interacted_by")
	get_node(Interactable_Path).connect("interacted_by", self, "_on_interacted")
	get_node(Interactable_Path).title = BehaviorTree.character_name
	add_child(BehaviorTree)
	#Load settings
	BehaviorTree.load_colors()
	
func _process_server(delta):
	worker.work(delta)
func _on_interacted(anything):
	BehaviorTree.emit_signal("interacted_by", anything)

func _on_worker_stopped(category):
	BehaviorTree.emit_signal("stopped_working", category)

func _on_request_rejected():
	BehaviorTree.emit_signal("request_rejected", null)  #Signals must carry at least 1 variable

func _on_worker_assigned(where):
	BehaviorTree.emit_signal("workstation_assigned", where)
