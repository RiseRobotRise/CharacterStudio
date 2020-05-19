extends HBoxContainer
class_name DoubleLabel

func _init(left_title : String = "", right_title : String = ""):
	var Label1 = Label.new()
	Label1.text = left_title
	var Label2 = Label.new()
	Label2.text = right_title
	add_child(Label1)
	add_child(Label2)
