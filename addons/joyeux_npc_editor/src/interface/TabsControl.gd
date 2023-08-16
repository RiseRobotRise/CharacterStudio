extends VBoxContainer

export(NodePath) var Packaging
export(NodePath) var Behavioural

onready var behaviours = get_node(Behavioural)


func _ready():
	#Ask our CurrentPackageInfo singleton about the character names
	#Add the names to our $ActorList
	for character in CurrentPackageInfo.characters:
		$ActorList.add_option(character.name)
	pass
	

func _on_Behavioral_pressed():
	$Behavioural.pressed = true
	behaviours.show()
	pass # Replace with function body.


func _on_Preview_pressed():
	pass # Replace with function body.



func _on_Packaging_selected_type():
	#We gotta do something here
	pass # Replace with function body.
