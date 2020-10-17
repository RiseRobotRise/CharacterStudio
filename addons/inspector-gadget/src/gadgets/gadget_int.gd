class_name GadgetInt
extends InspectorGadgetBase
tool

func _init(in_node_path: NodePath = NodePath(), in_subnames: String = "").(in_node_path, in_subnames):
	pass

static func supports_type(value) -> bool:
	if value is int:
		return true
	return false

func has_controls() -> bool:
	return has_node("SpinBox")

func get_controls() -> Array:
	return [$SpinBox]

func populate_controls() -> void:
	var spin_box = SpinBox.new()
	spin_box.name = "SpinBox"
	spin_box.min_value = 0
	spin_box.max_value = 0
	spin_box.allow_greater = true
	spin_box.allow_lesser = true
	spin_box.step = 1
	spin_box.rounded = true
	spin_box.set_anchors_and_margins_preset(PRESET_WIDE)
	spin_box.connect("value_changed", self, "set_int_value")
	add_child(spin_box)

func set_int_value(value) -> void:
	set_node_value(int(value))

func populate_value(value) -> void:
	var spin_box = get_controls()[0]
	spin_box.set_block_signals(true)
	spin_box.value = value
	spin_box.set_block_signals(false)
	spin_box.editable = editable

func depopulate_value() -> void:
	var spin_box = get_controls()[0]
	spin_box.set_block_signals(true)
	spin_box.value = false
	spin_box.set_block_signals(false)
	spin_box.editable = false
