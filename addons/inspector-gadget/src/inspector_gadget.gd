@tool
class_name InspectorGadget
extends InspectorGadgetBase

@export var property_blacklist := [] # (Array, String)
@export var custom_gadget_paths: Dictionary := {}
@export var custom_gadget_metadata: Dictionary := {}
@export var container_type_hints: Dictionary := {}
@export var filter_built_in_properties: bool := true

func _init(in_node_path: NodePath = NodePath(), in_subnames: String = ""):
	super(in_node_path, in_subnames)
	pass

func set_node_path(new_node_path: NodePath):
	super.set_node_path(new_node_path)

	if not has_controls():
		return

	var vbox = get_controls()[0]

	for child in vbox.get_children():
		child.node_path = node_path

func set_subnames(new_subnames: String):
	super.set_subnames(new_subnames)

	if not has_controls():
		return

	var vbox = get_controls()[0]

	for child in vbox.get_children():
		child.node_path = node_path

static func supports_type(value) -> bool:
	return value is Object or value is Dictionary or InspectorGadgetUtil.is_array_type(value) or value == null

func has_controls() -> bool:
	return has_node("PanelContainer")

func get_controls() -> Array:
	return [$PanelContainer/VBoxContainer]

func populate_controls() -> void:
	var vbox_container = VBoxContainer.new()
	vbox_container.name = "VBoxContainer"
	vbox_container.size_flags_horizontal = SIZE_EXPAND_FILL

	var panel_container = PanelContainer.new()
	panel_container.name = "PanelContainer"
	panel_container.size_flags_horizontal = SIZE_FILL
	panel_container.add_child(vbox_container)

	add_child(panel_container)

func populate_value(value) -> void:
	var vbox = get_controls()[0]
	if value is Object:
		var property_list = value.get_property_list()
		for property in property_list:
			if property['name'] in property_blacklist:
				continue

			var is_editor_variable = PROPERTY_USAGE_EDITOR & property['usage'] == PROPERTY_USAGE_EDITOR

			if not is_editor_variable:
				continue

			var is_script_variable = PROPERTY_USAGE_SCRIPT_VARIABLE & property['usage'] == PROPERTY_USAGE_SCRIPT_VARIABLE

			if filter_built_in_properties:
				if not is_script_variable:
					continue

			var property_name = property['name']

			var label = Label.new()
			label.text = property_name.capitalize()
			vbox.add_child(label)

			var gadget: InspectorGadgetBase = get_gadget_for_type(value[property_name], subnames + ":" + property_name, property_name)
			if gadget:
				gadget.name = property_name
				gadget.size_flags_horizontal = SIZE_EXPAND_FILL
				gadget.node_path = "../../../" + node_path
				if subnames != "":
					gadget.subnames = subnames + ":" + property_name
				else:
					gadget.subnames = ":" + property_name
				gadget.connect("change_property_begin", Callable(self, "change_property_begin"))
				gadget.connect("change_property_end", Callable(self, "change_property_end"))
				gadget.connect("gadget_event", Callable(self, "gadget_event"))

				if 'custom_gadget_paths' in gadget:
					gadget.custom_gadget_paths = custom_gadget_paths

				if 'custom_gadget_metadata' in gadget:
					gadget.custom_gadget_metadata = custom_gadget_metadata

				if 'container_type_hints' in gadget:
					gadget.container_type_hints = container_type_hints

				if 'filter_built_in_properties' in gadget:
					gadget.filter_built_in_properties = filter_built_in_properties

				vbox.add_child(gadget)

				var separator = HSeparator.new()
				separator.size_flags_horizontal = SIZE_EXPAND_FILL
				vbox.add_child(separator)
	elif InspectorGadgetUtil.is_array_type(value):
		for i in range(0, value.size()):
			var label = Label.new()
			label.text = String(i)

			var hbox := HBoxContainer.new()
			hbox.size_flags_horizontal = SIZE_EXPAND_FILL
			hbox.add_child(label)

			var gadget: InspectorGadgetBase = get_gadget_for_type(value[i], subnames)
			if gadget:
				gadget.size_flags_horizontal = SIZE_EXPAND_FILL
				gadget.node_path = "../../../../" + node_path
				gadget.subnames = subnames + ":" + String(i)
				gadget.connect("change_property_begin", Callable(self, "change_property_begin"))
				gadget.connect("change_property_end", Callable(self, "change_property_end"))
				gadget.connect("gadget_event", Callable(self, "gadget_event"))

				if 'custom_gadget_paths' in gadget:
					gadget.custom_gadget_paths = custom_gadget_paths

				if 'custom_gadget_metadata' in gadget:
					gadget.custom_gadget_metadata = custom_gadget_metadata

				if 'container_type_hints' in gadget:
					gadget.container_type_hints = container_type_hints

				if 'filter_built_in_properties' in gadget:
					gadget.filter_built_in_properties = filter_built_in_properties

				hbox.add_child(gadget)

			if editable:
				var delete_button := Button.new()
				delete_button.text = "X"
				delete_button.connect("pressed", Callable(self, "remove_array_element").bind(value, i))
				hbox.add_child(delete_button)

			vbox.add_child(hbox)

			if i < value.size() - 1:
				var separator = HSeparator.new()
				separator.size_flags_horizontal = SIZE_EXPAND_FILL
				vbox.add_child(separator)

		if editable:
			var separator = HSeparator.new()
			separator.size_flags_horizontal = SIZE_EXPAND_FILL
			vbox.add_child(separator)

			var new_button = Button.new()
			new_button.text = "+ New"

			var type_hint = null
			if subnames in container_type_hints:
				type_hint = container_type_hints[subnames]
			else:
				if value is PackedByteArray:
					type_hint = 0
				elif value is PackedInt32Array:
					type_hint = 0
				elif value is PackedFloat32Array:
					type_hint = 0.0
				elif value is PackedStringArray:
					type_hint = ""
				elif value is PackedVector2Array:
					type_hint = Vector2.ZERO
				elif value is PackedVector3Array:
					type_hint = Vector3.ZERO
				elif value is PackedColorArray:
					type_hint = Color.WHITE

			new_button.connect("pressed", Callable(self, "add_array_element").bind(value, type_hint))
			vbox.add_child(new_button)
	elif value is Dictionary:
		var keys = value.keys()
		var vals = value.values()
		for i in range(0, keys.size()):
			var key = keys[i]
			var val = vals[i]

			var key_gadget: InspectorGadgetBase = get_gadget_for_type(key, subnames + ":[keys]")
			if key_gadget:
				key_gadget.size_flags_horizontal = SIZE_EXPAND_FILL
				key_gadget.node_path = "../../../../../" + node_path
				key_gadget.subnames = subnames + ":[keys]:" + String(i)
				key_gadget.connect("change_property_begin", Callable(self, "change_property_begin"))
				key_gadget.connect("change_property_end", Callable(self, "change_property_end"))
				key_gadget.connect("gadget_event", Callable(self, "gadget_event"))

				if 'custom_gadget_paths' in key_gadget:
					key_gadget.custom_gadget_paths = custom_gadget_paths

				if 'custom_gadget_metadata' in key_gadget:
					key_gadget.custom_gadget_metadata = custom_gadget_metadata

				if 'container_type_hints' in key_gadget:
					key_gadget.container_type_hints = container_type_hints

				if 'filter_built_in_properties' in key_gadget:
					key_gadget.filter_built_in_properties = filter_built_in_properties

			var value_gadget: InspectorGadgetBase = get_gadget_for_type(val, subnames + ":[values]")
			if value_gadget:
				value_gadget.size_flags_horizontal = SIZE_EXPAND_FILL
				value_gadget.node_path = "../../../../../" + node_path
				value_gadget.subnames = subnames + ":[values]:" + String(i)
				value_gadget.connect("change_property_begin", Callable(self, "change_property_begin"))
				value_gadget.connect("change_property_end", Callable(self, "change_property_end"))
				value_gadget.connect("gadget_event", Callable(self, "gadget_event"))

				if 'custom_gadget_paths' in value_gadget:
					value_gadget.custom_gadget_paths = custom_gadget_paths

				if 'custom_gadget_metadata' in value_gadget:
					value_gadget.custom_gadget_metadata = custom_gadget_metadata

				if 'container_type_hints' in value_gadget:
					value_gadget.container_type_hints = container_type_hints

				if 'filter_built_in_properties' in value_gadget:
					value_gadget.filter_built_in_properties = filter_built_in_properties


			var hbox = HBoxContainer.new()
			hbox.size_flags_horizontal = SIZE_EXPAND_FILL
			hbox.size_flags_vertical = SIZE_EXPAND_FILL
			hbox.add_child(key_gadget)
			hbox.add_child(value_gadget)

			if editable:
				var delete_button := Button.new()
				delete_button.text = "X"
				delete_button.connect("pressed", Callable(self, "remove_dictionary_element").bind(value, key))
				hbox.add_child(delete_button)

			var panel_container = PanelContainer.new()
			panel_container.add_child(hbox)

			vbox.add_child(panel_container)

		if editable:
			var separator = HSeparator.new()
			separator.size_flags_horizontal = SIZE_EXPAND_FILL
			vbox.add_child(separator)

			var new_button = Button.new()
			new_button.text = "+ New"

			var key_type_hint = null
			if subnames + ":[keys]" in container_type_hints:
				key_type_hint = container_type_hints[subnames + ":[keys]"]

			var value_type_hint = null
			if subnames + ":[values]" in container_type_hints:
				value_type_hint = container_type_hints[subnames + ":[values]"]

			new_button.connect("pressed", Callable(self, "add_dictionary_element").bind(value, key_type_hint, value_type_hint))
			vbox.add_child(new_button)

func add_array_element(array, type_hint) -> void:
	var _node = _node_ref.get_ref()
	if not _node:
		return

	change_property_begin(_node, subnames)
	var value = null
	if type_hint is Script:
		value = type_hint.new()
	else:
		value = type_hint

	array.append(value)
	if not InspectorGadgetUtil.is_by_ref_type(array):
		set_node_value(array)

	change_property_end(_node, subnames)

func remove_array_element(array, index: int) -> void:
	var _node = _node_ref.get_ref()
	if not _node:
		return

	change_property_begin(_node, subnames)

	array.remove(index)
	if not InspectorGadgetUtil.is_by_ref_type(array):
		set_node_value(array)

	change_property_end(_node, subnames)

func add_dictionary_element(dict: Dictionary, key_type_hint, value_type_hint) -> void:
	var _node = _node_ref.get_ref()
	if not _node:
		return

	change_property_begin(_node, subnames)
	var key = null
	if key_type_hint is Script:
		key = key_type_hint.new()
	else:
		key = key_type_hint

	var value = null
	if value_type_hint is Script:
		value = value_type_hint.new()
	else:
		value = value_type_hint

	dict[key] = value
	change_property_end(_node, subnames)

func remove_dictionary_element(dict: Dictionary, key) -> void:
	var _node = _node_ref.get_ref()
	if not _node:
		return

	change_property_begin(_node, subnames)
	dict.erase(key)
	change_property_end(_node, subnames)

func depopulate_value() -> void:
	var vbox = get_controls()[0]
	for child in vbox.get_children():
		vbox.remove_child(child)
		child.queue_free()

func get_gadget_for_type(value, subnames: String, property_name: String = "") -> InspectorGadgetBase:
	var gadget: InspectorGadgetBase = null

	if subnames in custom_gadget_paths:
		return custom_gadget_paths[subnames].new()

	match typeof(value):
		TYPE_NIL:
			pass
		TYPE_BOOL:
			gadget = GadgetBool.new()
		TYPE_INT:
			gadget = GadgetInt.new()
		TYPE_FLOAT:
			gadget = GadgetFloat.new()
		TYPE_STRING:
			gadget = GadgetStringEdit.new()
		TYPE_VECTOR2:
			gadget = GadgetVector2.new()
		TYPE_RECT2:
			gadget = GadgetRect2.new()
		TYPE_VECTOR3:
			gadget = GadgetVector3.new()
		TYPE_TRANSFORM2D:
			gadget = GadgetTransform2D.new()
		TYPE_PLANE:
			gadget = GadgetPlane.new()
		TYPE_QUATERNION:
			gadget = GadgetQuat.new()
		TYPE_AABB:
			gadget = GadgetAABB.new()
		TYPE_BASIS:
			gadget = GadgetBasis.new()
		TYPE_TRANSFORM3D:
			gadget = GadgetTransform.new()
		TYPE_COLOR:
			gadget = GadgetColor.new()
		TYPE_RID:
			gadget = GadgetRID.new()
		TYPE_OBJECT:
			gadget = get_script().new()
		TYPE_DICTIONARY:
			gadget = get_script().new()
		TYPE_ARRAY:
			gadget = get_script().new()
		TYPE_PACKED_BYTE_ARRAY:
			gadget = get_script().new()
		TYPE_PACKED_INT32_ARRAY:
			gadget = get_script().new()
		TYPE_PACKED_FLOAT32_ARRAY:
			gadget = get_script().new()
		TYPE_PACKED_STRING_ARRAY:
			gadget = get_script().new()
		TYPE_PACKED_VECTOR2_ARRAY:
			gadget = get_script().new()
		TYPE_PACKED_VECTOR3_ARRAY:
			gadget = get_script().new()
		TYPE_PACKED_COLOR_ARRAY:
			gadget = get_script().new()

	return gadget

func set_value_for_prop(prop_name : String, value):
	var node : InspectorGadgetBase = get_node_or_null("PanelContainer/VBoxContainer/"+prop_name)
	if node:
		if node.supports_type(value):
			node.set_node_value(value)
