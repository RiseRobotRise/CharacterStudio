@tool
extends FileDialog

@export var Start_path # (String, DIR)

func _enter_tree():
	if not Engine.is_editor_hint():
		access = FileDialog.ACCESS_USERDATA
		current_dir = "user://behaviors/"
		current_path = "user://behaviors/"

func set_open():
	mode = FileDialog.FILE_MODE_OPEN_FILE 

func set_save():
	mode = FileDialog.FILE_MODE_SAVE_FILE
