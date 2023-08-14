extends VBoxContainer

export(NodePath) var Packaging
export(NodePath) var Behavioural

onready var behaviours = get_node(Behavioural)



func _on_Behavioral_pressed():
	$Behavioural.pressed = true
	behaviours.show()
	pass # Replace with function body.


func _on_Preview_pressed():
	pass # Replace with function body.

