@tool
extends HBoxContainer
class_name FileLabel

func _init(filters = ""):
	if filters != "":
		var button = Button.new()
		button.text = "Open..."
		button.name = "Button"
		var Dialog = FileDialog.new()
		Dialog.mode = 0
		Dialog.filters = filters.rsplit(",")
		Dialog.name = "OpenFile"
		var Text = LineEdit.new()
		Text.name = "Text"
		Text.editable = false
		add_child(button)
		add_child(Text)
		add_child(Dialog)

func _ready():
	get_node("Button").connect("pressed", Callable(self, "open_file"))
	get_node("OpenFile").connect("about_to_popup", Callable(get_node("Text"), "clear"))
	get_node("OpenFile").connect("file_selected", Callable(get_node("Text"), "append_at_cursor"))
	get_node("OpenFile").get_cancel_button().connect("pressed", Callable(get_node("Text"), "clear"))
	get_node("OpenFile").custom_minimum_size = Vector2(400,500)
	get_node("Text").editable = false
	pass

func open_file():
	get_node("OpenFile").popup_centered()
