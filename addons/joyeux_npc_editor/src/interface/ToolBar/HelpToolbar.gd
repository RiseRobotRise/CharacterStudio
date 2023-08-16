extends MenuButton

enum id_names{
	ABOUT,
	HELP
}


# Called when the node enters the scene tree for the first time.
func _ready():
	get_popup().connect("index_pressed", self, "_on_id_pressed")
	pass # Replace with function body.


func _on_id_pressed(id : int):
	print(id)
	match id:
		id_names.ABOUT:
			get_node("%AboutDialog").popup_centered()
		id_names.HELP:
			pass
