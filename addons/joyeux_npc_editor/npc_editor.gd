@tool
extends EditorPlugin

const main_panel = preload("res://addons/joyeux_npc_editor/src/interface/Addon_UI.tscn")
const lang = [
	"res://addons/joyeux_npc_editor/lang/npc_editor_label_translation.en.position",
	"res://addons/joyeux_npc_editor/lang/npc_editor_label_translation.es.position"
]
var main_panel_instance

func _enter_tree():
	
	if ProjectSettings.get("locale/translations") == null:
		ProjectSettings.set("locale/translations", PackedStringArray())
		pass
	var current_translations : PackedStringArray = ProjectSettings.get("locale/translations")
	for locale in lang:
		if locale in current_translations:
			continue
		else:
			current_translations.append(locale)
	ProjectSettings.set("locale/translations", current_translations)

	if not Engine.has_singleton("Nodes"):
		add_autoload_singleton("Nodes", "res://addons/joyeux_npc_editor/src/Core/Nodes.gd")
	main_panel_instance = main_panel.instantiate()
	get_editor_interface().get_editor_main_screen().add_child(main_panel_instance)
	_make_visible(false)

func _exit_tree():
	
	var current_translations : PackedStringArray = ProjectSettings.get("locale/translations")
	var new_translations : PackedStringArray = PackedStringArray()
	for position in current_translations:
		if position in lang:
			continue
		else:
			new_translations.append(position)
	ProjectSettings.set("locale/translations", new_translations)
	
	if Engine.has_singleton("Nodes"):
		remove_autoload_singleton("Nodes")
	if main_panel_instance:
		main_panel_instance.queue_free()
	pass




func _make_visible(visible):
	if main_panel_instance:
		main_panel_instance.visible = visible

func _has_main_screen():
	return true
func _get_plugin_name():
	return TranslationServer.translate("NPC Editor")
