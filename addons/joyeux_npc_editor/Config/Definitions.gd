tool
extends Resource
class_name NpcDefinitions

#Class ID will be assigned from 27 and on, in the order classes are declared


var CLASS_CHARACTER =  {
	"_color" : Color(.5,.5,.1,1),
	"_object_type" : "Character",
	"_variables" : {
		"team" : TYPE_INT,
		"translation" : TYPE_VECTOR3,
		"health" : TYPE_REAL,
		"shield" : TYPE_REAL,
		}
	}

var CLASS_WORKSTATION = {
	"_color" : Color(0,0,0,1),
	"_object_type" : "Misc",
	"_variables" : {
		"category" : [
				"WORK",
				"FOOD",
				"ENTERTAINMENT",
				"PERSON",
				"OTHERS"
			]
	}
}

#Do not use spaces, numbers or symbols in function defintions. 
#_s_ prefix indicates the label would be replaced with a special component
#This prefix only works in the input label.
var _functions = {
	"character_property_check" : {
		"_category" : "inhibitors",
		"_code" : "FuncRef?", #This hasn't been implemented yet
		"_input_ports" : [
			{"_label_title":"Character", "_type" : "CLASS_CHARACTER"},
			{"_label_title":"_s_prop_dropdown_CHARACTER", "_type" : TYPE_NIL}
		],
		"_output_ports" : [
			{"_label_title" : "Property content", "_type" : Nodes.TYPE_ANY},
		]
	},
	"workstation_property_check" : {
		"_category" : "inhibitors",
		"_code" : "FuncRef?", #This hasn't been implemented yet
		"_input_ports" : [
			{"_label_title":"Character", "_type" : "CLASS_WORKSTATION"},
			{"_label_title":"_s_prop_dropdown_WORKSTATION", "_type" : TYPE_NIL}
		],
		"_output_ports" : [
			{"_label_title" : "Property content", "_type" : Nodes.TYPE_ANY},
		]
	},
	"match" : {
		"_category" : "inhibitors",
		"_input_ports" : [
			{"_label_title":"String input", "_type" : TYPE_STRING},
			{"_label_title":"_s_text_edit", "_type" : TYPE_NIL}
		],
		"_output_ports" : [
			{"_label_title" : "Does Match", "_type" : TYPE_BOOL },
		]
	},
	"delay" : {
		"_category" : "inhibitors",
		"_input_ports" : [
			{"_label_title":"Trigger", "_type" : Nodes.TYPE_ANY},
			{"_label_title":"_s_float", "_type" : TYPE_NIL}
		],
		"_output_ports" : [
			{"_label_title" : "Next", "_type" : Nodes.TYPE_ANY },
		]
	},
	"tri_v_decision" : {
		"_category" : "inhibitors",
		"_input_ports" : [
			{"_label_title":"Value", "_type" : Nodes.TYPE_ANY},
			{"_label_title":"Weight 1", "_type" : TYPE_REAL},
			{"_label_title":"Weight 2", "_type" : TYPE_REAL},
			{"_label_title":"Weight 3", "_type" : TYPE_REAL}
		],
		"_output_ports" : [
			{"_label_title" : "", "_type" : TYPE_NIL },
			{"_label_title" : "Output 1", "_type" : Nodes.TYPE_ANY },
			{"_label_title" : "Output 2", "_type" : Nodes.TYPE_ANY },
			{"_label_title" : "Output 3", "_type" : Nodes.TYPE_ANY }
		]
	},
	"parallel_trigger" : {
		"_category" : "misc",
		"_input_ports" : [
			{"_label_title":"Signal Entry","_type":Nodes.TYPE_ANY},
			],
		"_output_ports" : [
			{"_label_title":"Trigger 1","_type":Nodes.TYPE_ANY},
			{"_label_title":"Trigger 2","_type":Nodes.TYPE_ANY}
			]
	}, 
	"set_objective" : {
		"_category" : "actions",
		"_input_ports" : [
			{"_label_title":"Objective position","_type":TYPE_VECTOR3},
			],
		"_output_ports" : [
			{"_label_title":"","_type":TYPE_NIL},
			]
	},
	"shoot_principal" : {
		"_category" : "actions",
		"_input_ports" : [
			{"_label_title":"Towards","_type":TYPE_VECTOR3},
			],
		"_output_ports" : [
			{"_label_title":"","_type":TYPE_NIL},
			]
	},
	"shoot_secondary" : {
		"_category" : "actions",
		"_input_ports" : [
			{"_label_title":"Towards","_type":TYPE_VECTOR3},
			],
		"_output_ports" : [
			{"_label_title":"","_type":TYPE_NIL},
			]
	},
	"trigger_dialog" : {
		"_category" : "actions",
		"_input_ports" : [
			{"_label_title":"_s_file:*.mtalk ; Dialog File","_type":Nodes.TYPE_ANY},
			],
		"_output_ports" : [
			{"_label_title":"","_type":TYPE_NIL},
			]
	},
	"find_workstation" : {
		"_category" : "actions",
		"_input_ports" : [
			{"_label_title":"Trigger","_type":Nodes.TYPE_ANY},
			{"_label_title": "_s_enum_dropdown_category_WORKSTATION", "_type":TYPE_NIL}
			],
		"_output_ports" : [
			{"_label_title":"Station Position","_type":TYPE_VECTOR3},
			]
	},
	"request_workstation" : {
		"_category" : "actions",
		"_input_ports" : [
			{"_label_title":"Trigger","_type":Nodes.TYPE_ANY},
			{"_label_title": "_s_enum_dropdown_category_WORKSTATION", "_type":TYPE_NIL}
			],
		"_output_ports" : [
			{"_label_title":"","_type":TYPE_NIL},
			]
	},
	"play_global_sound" : {
		"_category" : "actions",
		"_input_ports" : [
			{"_label_title":"_s_file:*.ogg ; OGG Audio,*.wav ; WAV audio,*.mp3 ; MP3 Audio","_type":Nodes.TYPE_ANY},
			],
		"_output_ports" : [
			{"_label_title":"","_type":TYPE_NIL},
			]
	},
	"play_pos_sound" : {
		"_category" : "actions",
		"_input_ports" : [
			{"_label_title":"_s_file:*.ogg ; OGG Audio,*.wav ; WAV audio,*.mp3 ; MP3 Audio","_type":Nodes.TYPE_ANY},
			],
		"_output_ports" : [
			{"_label_title":"","_type":TYPE_NIL},
			]
	},
	"force_next_state" : {
		"_category" : "actions",
		"_input_ports" : [
			{"_label_title":"Trigger","_type":Nodes.TYPE_ANY},
			],
		"_output_ports" : [
			{"_label_title":"","_type":TYPE_NIL},
			]
	} 
}

var _stimulus = {
	#This section exposes engine signals
	"on_ready" :{
		"_output_name": "Trigger",
		"_output_type": Nodes.TYPE_ANY,
	},
	"tree_exiting" :{
		"_output_name": "Trigger",
		"_output_type": Nodes.TYPE_ANY,
	}, 
	"visibility_changed" :{
		"_output_name": "Trigger",
		"_output_type": Nodes.TYPE_ANY,
	},
	#This section is for user designed signals
	
	"wounded" :{
		"_output_name": "Damage",
		"_output_type": TYPE_REAL,
	},
	"radio_pos" :{
		"_output_name": "Given position",
		"_output_type": TYPE_VECTOR3,
	},
	"sight" :{
		"_output_name": "Sight info",
		"_output_type": TYPE_DICTIONARY ,
	},
	"character_entered" :{
		"_output_name": "Character",
		"_output_type": "CLASS_CHARACTER",
	},
	"hear" :{
		"_output_name": "Hearing info",
		"_output_type": TYPE_OBJECT,
	},
	"radio_object" :{
		"_output_name": "Object",
		"_output_type": TYPE_OBJECT,
	},
	"stopped_working" :{
		"_output_name": "Category",
		"_output_type": TYPE_STRING,
	},
	"workstation_assigned" :{
		"_output_name": "Position",
		"_output_type": TYPE_VECTOR3,
	},
	"request_rejected" :{
		"_output_name": "Trigger",
		"_output_type": Nodes.TYPE_ANY,
	},
	
}
