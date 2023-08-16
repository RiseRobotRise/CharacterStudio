tool
extends EditorPlugin

const main_panel = preload("res://addons/joyeux_npc_editor/src/interface/Addon_UI.tscn")
const lang = [
	"res://addons/joyeux_npc_editor/lang/npc_editor_label_translation.en.translation",
	"res://addons/joyeux_npc_editor/lang/npc_editor_label_translation.es.translation"
]
var main_panel_instance

func _enter_tree():
	
	if ProjectSettings.get("locale/translations") == null:
		ProjectSettings.set("locale/translations", PoolStringArray())
		pass
	var current_translations : PoolStringArray = ProjectSettings.get("locale/translations")
	for locale in lang:
		if locale in current_translations:
			continue
		else:
			current_translations.append(locale)
	ProjectSettings.set("locale/translations", current_translations)

	if not Engine.has_singleton("Nodes"):
		add_autoload_singleton("Nodes", "res://addons/joyeux_npc_editor/src/Core/Nodes.gd")
	main_panel_instance = main_panel.instance()
	get_editor_interface().get_editor_viewport().add_child(main_panel_instance)
	make_visible(false)

func _exit_tree():
	
	var current_translations : PoolStringArray = ProjectSettings.get("locale/translations")
	var new_translations : PoolStringArray = PoolStringArray()
	for translation in current_translations:
		if translation in lang:
			continue
		else:
			new_translations.append(translation)
	ProjectSettings.set("locale/translations", new_translations)
	
	if Engine.has_singleton("Nodes"):
		remove_autoload_singleton("Nodes")
	if main_panel_instance:
		main_panel_instance.queue_free()
	pass




func make_visible(visible):
	if main_panel_instance:
		main_panel_instance.visible = visible

func has_main_screen():
	return true
func get_plugin_name():
	return TranslationServer.translate("NPC Editor")
