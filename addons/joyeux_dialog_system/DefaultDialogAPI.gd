extends VBoxContainer

@onready var CharNameEdit = $PanelContainer/HBC/HBC/CharName
@onready var Graph = $Graph
@onready var FileMenu = $PanelContainer/HBC/File
@onready var Dialog = $Graph/Dialogs/FileDialog
@onready var Warn = $Graph/Dialogs/AcceptDialog

func _ready() -> void:
	FileMenu.get_popup().connect("id_pressed", Callable(self, "_on_File_id_pressed"))


func _on_File_id_pressed(id : int):
	match id:
		0:
			Dialog.set_open()
			Dialog.popup_centered()
		1:
			if CharNameEdit.text == "":
				warn("Please name your character first")
				return
			Dialog.set_save()
			Dialog.popup_centered()

func _on_FileDialog_file_selected(path):
	match Dialog.mode:
		FileDialog.FILE_MODE_SAVE_FILE:
			Graph.save_dialogs(path, CharNameEdit.text)
		FileDialog.FILE_MODE_OPEN_FILE:
			Graph.load_dialogs(path)
			

func warn(what : String):
	Warn.dialog_text = TranslationServer.translate(what)
	Warn.popup_centered()


func _on_AcceptDialog_confirmed():
	CharNameEdit.grab_focus()
