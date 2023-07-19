@tool
extends FileDialog

func _enter_tree():
	if not Engine.is_editor_hint():
		access = FileDialog.ACCESS_USERDATA
		var Dir = DirAccess.new()
		if not Dir.dir_exists("user://NPCDialogs/"):
			Dir.make_dir("user://NPCDialogs/")
		
		current_dir = "user://NPCDialogs/"
		current_path = "user://NPCDialogs/"

func set_open():
	mode = FileDialog.FILE_MODE_OPEN_FILE 

func set_save():
	mode = FileDialog.FILE_MODE_SAVE_FILE
