@tool
extends PanelContainer

@export var default_scene: PackedScene = load("res://addons/joyeux_dialog_system/src/editor/editor.tscn")
@export var dialogic_editor_path = "res://addons/dialogic/Editor/EditorView.tscn" # (String, FILE, "*.tscn")

func _ready():
	var editor = File.new()
	if editor.file_exists(dialogic_editor_path):
		editor = load(dialogic_editor_path).instantiate()
	else:
		editor = default_scene.instantiate()
	add_child(editor)
	
