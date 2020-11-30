extends NPCBase
class_name JxNPC

"""
This is the actual class to be edited, extends the NPCBase and has the functions
that appear in the Definitions file.
"""

signal interacted_by(something)
signal workstation_assigned(which)


#### Properties ####
export(float) var attack_min_range = 10
export(float) var attack_max_range = 50
export(float) var health : float = 100
export(float) var shield : float = 0
export(Color) var primary_color : Color = Color("white")
export(Color) var secondary_color : Color = Color("white")
export(String) var character_name : String = ""
#######################



var actor : Spatial = null
var worker = null
var navigator  = null

func _init(file:= "", state:= ""):
	NPC_File = file 
	initial_state = state

func load_colors():
	actor.get_component("ModelComponent").set_colors(primary_color)
	actor.get_component("ModelComponent").set_name(secondary_color)
	
func property_check(input, signals, variables):
	#input is object, get the specific variable in the variable port and then
	#passes it to the next node
	var filter = _get_variable_from_port(variables, 1)
	if input.has(filter):
		_emit_signal_from_port(input.get(filter), signals, 0)

func match(input, signals, variables):
	#Checks if input matches with the variable input, if it does
	#calls the next node
	if input == _get_variable_from_port(variables, 1):
		_emit_signal_from_port(true, signals, 0)

func delay(input, signals, variables):
	var time = float(_get_variable_from_port(variables, 1))
	if time > 0:
		yield(get_tree().create_timer(time), "timeout")
	_emit_signal_from_port(input, signals, 0)

func parallel_trigger(input, signals, variables):
	#Takes the contents of a signal and distributes it along other two nodes
	_emit_signal_from_port(input, signals, 0)
	_emit_signal_from_port(input, signals, 1)

func force_next_state(input, signals, variables):
	emit_signal("next_state", true)

func tri_v_decision(input, signals, variables):
	var weight1 = _get_variable_from_port(variables, 1)
	var weight2 = _get_variable_from_port(variables, 2)
	var weigth3 = _get_variable_from_port(variables, 3)
	var maximum = max(weight1, max(weight2, weigth3))
	if maximum == weight1:
		_emit_signal_from_port(input, signals, 1)
	elif maximum == weight2:
		_emit_signal_from_port(input, signals, 2)
	elif maximum == weigth3:
		_emit_signal_from_port(input, signals, 3)

func play_global_sound(input, signals, variables):
	var path = _get_variable_from_port(variables, 0)
	var sound_player = AudioStreamPlayer.new()
	sound_player.stream = load(path)
	sound_player.connect("finished", sound_player, "queue_free")
	actor.add_child(sound_player)
	sound_player.play()

func play_3d_sound(input, signals, variables):
	var path = _get_variable_from_port(variables, 0)
	var sound_player = AudioStreamPlayer3D.new()
	sound_player.stream = load(path)
	sound_player.connect("finished", sound_player, "queue_free")
	actor.add_child(sound_player)
	sound_player.play()
"""
func trigger_dialog(input, signals, variables):
	var path = _get_variable_from_port(variables, 0)
	var dialog_display = DialogDisplay.instance()
	dialog_display.dialog = path
	dialog_display.name_override = character_name 
	actor.add_child(dialog_display)
	dialog_display.connect("finished", dialog_display, "queue_free")
"""
func request_workstation(input, signals, variables):
	if worker.current_station != null:
		return
	var filter = _get_variable_from_port(variables, 1)
	navigator.world_ref.request_workstation(worker, filter)

func find_workstation(input, signals, variables):
	var filter = _get_variable_from_port(variables, 1)
	var destination = navigator.world_ref.get_nearest_workstation(actor.translation, filter).position
	_emit_signal_from_port(input, signals, 0) #This is, emmits a Vector3 position
	
func set_objective(input, _signals, _variables):
	navigator.get_navpath(input) #Input should be Vector3
