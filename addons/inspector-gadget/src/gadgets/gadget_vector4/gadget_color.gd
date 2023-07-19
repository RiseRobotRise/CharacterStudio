@tool
class_name GadgetColor
extends GadgetVector4

var colorbox : StyleBoxFlat = _set_colorbox()

func _set_colorbox() -> StyleBoxFlat:
	var colorbox :StyleBoxFlat= StyleBoxFlat.new()
	colorbox.border_color = Color(0.301961, 0.298039, 0.34902)
	colorbox.set_corner_radius_all(1)
	colorbox.set_border_width_all(1)
	return colorbox

func _set_button_stylebox(button, colorbox):
	button.add_theme_stylebox_override("normal", colorbox)
	button.add_theme_stylebox_override("pressed", colorbox)
	button.add_theme_stylebox_override("focus", colorbox)
	button.add_theme_stylebox_override("hover", colorbox)
	button.custom_minimum_size = Vector2(50,10)

func _init(in_node_path: NodePath = NodePath(), in_subnames: String = ""):
	super(in_node_path, in_subnames)
	x_axis = "r"
	y_axis = "g"
	z_axis = "b"
	w_axis = "a"
	await self.ready
	var button = Button.new()
	button.text = "Pick"
	
	var popup = PopupColor.new()
	popup.connect("color_changed", Callable(self, "set_node_value"))
	get_node("HBoxContainer/FloatGadgetX").connect("value_changed", Callable(popup, "change_color_r"))
	get_node("HBoxContainer/FloatGadgetY").connect("value_changed", Callable(popup, "change_color_g"))
	get_node("HBoxContainer/FloatGadgetZ").connect("value_changed", Callable(popup, "change_color_b"))
	get_node("HBoxContainer/FloatGadgetW").connect("value_changed", Callable(popup, "change_color_a"))
	
	get_node("HBoxContainer/FloatGadgetX").connect("value_changed", Callable(self, "change_colorbox").bind("r"))
	get_node("HBoxContainer/FloatGadgetY").connect("value_changed", Callable(self, "change_colorbox").bind("g"))
	get_node("HBoxContainer/FloatGadgetZ").connect("value_changed", Callable(self, "change_colorbox").bind("b"))
	get_node("HBoxContainer/FloatGadgetW").connect("value_changed", Callable(self, "change_colorbox").bind("a"))
	
	button.connect("pressed", Callable(popup, "popup_centered"))
	get_node("HBoxContainer").add_child(button)
	_set_button_stylebox(button, colorbox)
	
	
	connect("value_changed", Callable(colorbox, "set_bg_color"))
	popup.connect("color_changed", Callable(colorbox, "set_bg_color"))
	add_child(popup)
	get_node("HBoxContainer").move_child(button, 0)
	
func change_colorbox(color : float, type : String):
	var current : Color = colorbox.get_bg_color()
	match type:
		"r":
			current.r = color 
		"g":
			current.g = color 
		"b":
			current.b = color 
		"a":
			current.a = color 
	colorbox.set_bg_color(current)
	
static func supports_type(value) -> bool:
	return value is Color

