extends Node


var project_name : String = ""
var version_loaded : String = ""

var characters : Dictionary = {} # Dictionary of String -> CharacterInfo

#Default structure for a project:
#Project.config (Actually a json file)
#Project/Characters/CharacterName/CharacterName.tscn #Scene file
#Project/Characters/CharacterName/CharacterName.json # Holds character info and variation sets

# On packaging, we include the Joyeuse AI module, and any animation modules that are used.



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



class VariationInfo:
	# VariationInfo is a class that holds information about a variation set
	# for a character. It holds the default values for the variation set, as
	# well as the current values for the variation set. It also holds the
	# variation keys, which are the keys that can be used to change the
	# variation values.
	# This is useful for things like character customization, where you can
	# have a set of values that can be changed to create a unique character.
	# For example, you could have a set of values for a character's hair color,
	# and a set of values for a character's eye color. This also applies to
	# health, speed, jump height, etc.

	var name : String = ""
	var variation_keys : Dictionary = {} # Dictionary of String -> Default value
	var variation_values : Dictionary = {} # Dictionary of String -> Current value

	func _init(name : String):
		self.name = name
	
	func set_variation_value(key : String, value):
		variation_values[key] = value

	func get_variation_value(key : String):
		if variation_values.has(key):
			return variation_values[key]
		else:
			return variation_keys[key]
	
	func get_variation_keys():
		return variation_keys.keys()
	
	func create_variation_key(key : String, default_value):
		variation_keys[key] = default_value
		variation_values[key] = default_value

class CharacterInfo:
	var name : String = ""
	var model : Spatial = null
	var model_path : String = ""
	var default_team : int = 0
	var default_variation_set : int = 0
	var variation_sets : Array = [] # Array of VariationInfo
	var default_hitpoints : float = 0
	var default_speed : float = 0
	var default_jump_height : float = 0
	var default_jump_duration : float = 0
	var default_special_cooldown : float = 0
	var default_special_duration : float = 0
	
	
	func _init(name : String):
		self.name = name
	
	func load_model(model_path : String):
		model = load(model_path).instance()

