@tool
extends VBoxContainer
@onready var default_project = $"HBoxContainer/Locations/Project Location/Path3D"
@onready var default_user = $"HBoxContainer/Locations/User Location/Path3D"

@onready var popup : ConfirmationDialog = $Dialogs/ConfirmationDialog
@onready var file : FileDialog = $Dialogs/FileDialog

signal default_changing(which)
signal confirm_or_cancel(which)

func _ready():
	default_project.text = Nodes.behavior_paths[0]
	default_user.text = Nodes.behavior_paths[1]
	connect("default_changing", Callable(self, "_on_default_changing"))

func _on_ProjLoc_pressed():
	emit_signal("default_changing", "project")

func _on_UserLoc_pressed():
	emit_signal("default_changing", "user")

func _on_default_changing(which : String):
	popup.popup_centered()
	await popup.confirmed
	match which:
		"project":
			file.set_project()
		"user":
			file.set_user()
	file.popup_centered()
	var result = await self.confirm_or_cancel
	if result == "cancel":
		return
	else:
		match which:
			"project":
				default_project.text = result
				Nodes.override_default(0, result) #0 is for project
			"user":
				default_user.text = result
				Nodes.override_default(1, result) #1 is for user
func _on_FileDialog_dir_selected(dir):
	emit_signal("confirm_or_cancel", dir)


func _on_FileDialog_popup_hide():
	emit_signal("confirm_or_cancel", "cancel")


func _on_Apply_pressed():
	Nodes.save_custom_paths()
