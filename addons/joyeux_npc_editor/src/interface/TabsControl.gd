extends VBoxContainer


@export var Packaging: NodePath
@export var Behavioural: NodePath
@export var Settings: NodePath

@onready var settings = get_node(Settings)
@onready var behaviours = get_node(Behavioural)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Packaging_pressed():
	pass # Replace with function body.


func _on_Behavioral_pressed():
	$Behavioural.button_pressed = true
	$Settings.button_pressed = false
	settings.hide()
	behaviours.show()
	pass # Replace with function body.


func _on_Preview_pressed():
	pass # Replace with function body.


func _on_Settings_pressed():
	$Behavioural.button_pressed = false
	$Settings.button_pressed = true
	settings.show()
	behaviours.hide()
	pass # Replace with function body.
