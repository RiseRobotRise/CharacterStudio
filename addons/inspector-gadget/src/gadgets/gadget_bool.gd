@tool
class_name GadgetBool
extends InspectorGadgetBase

func _init(in_node_path: NodePath = NodePath(), in_subnames: String = ""):
	super(in_node_path, in_subnames)
	pass

static func supports_type(value) -> bool:
	if value is bool:
		return true
	return false

func has_controls() -> bool:
	return has_node("CheckBox")

func get_controls() -> Array:
	return [$CheckBox]

func populate_controls() -> void:
	var check_box = CheckBox.new()
	check_box.name = "CheckBox"
	check_box.set_anchors_and_offsets_preset(PRESET_WIDE)
	check_box.connect("toggled", Callable(self, "set_node_value"))
	add_child(check_box)

func populate_value(value) -> void:
	var check_box = get_controls()[0]
	check_box.set_block_signals(true)
	check_box.button_pressed = value
	check_box.set_block_signals(false)
	check_box.disabled = !editable

func depopulate_value() -> void:
	var check_box = get_controls()[0]
	check_box.set_block_signals(true)
	check_box.button_pressed = false
	check_box.set_block_signals(false)
	check_box.disabled = true
