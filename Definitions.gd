extends Resource
class_name NpcDefinitions

#Class ID will be assigned from 27 and on, in the order classes are declared

var CLASS_MISC = {
	"_color" : Color(.5,.5,.1,1),
	"_object_type" : "Any",
	"_variables":{
		"Character" : "CLASS_CHARACTER",
		"Projectile" : "CLASS_PROJECTILE"
	}
}

var CLASS_PROJECTILE = {
	"_color" : Color(.1, .3,.5,1),
	"_object_type" : "Projectile",
	"_variables" : {
		"Owner" : "CLASS_CHARACTER",
		"Damage" : TYPE_REAL,
		"Target" : "CLASS_CHARACTER"
	}
}

var CLASS_CHARACTER =  {
	"_color" : Color(.5,.5,.1,1),
	"_object_type" : "Character",
	"_variables" : {
		"team" : TYPE_INT,
		"translation" : TYPE_VECTOR3,
		"type" : TYPE_STRING,
		"health" : TYPE_REAL,
		"shield" : TYPE_REAL,
		"target_location" : TYPE_VECTOR3}
	}
func misc(object : Object, property:String):
	object.get(property)
var _functions = {
	"filter" : {
		"_category" : "Misc",
		"_code" : "<actual code>",
		"_input_ports" : [
			{"_label_title":"title","_type":TYPE_NIL},
			{"_label_title":"title2","_type":TYPE_NIL}
			],
		"_output_ports" : [
			{"_label_title":"title","_type":TYPE_NIL},
			{"_label_title":"title2","_type":TYPE_NIL}
			]
	} 
}

var _stimulus = {
	"Hear" :{
		"_output_name": "Emmiter Data",
		"_output_type": "CLASS_MISC"
	}
}
