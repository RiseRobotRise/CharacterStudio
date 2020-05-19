extends NPCLogic


var TrivDec = Function.new(self,"trivalent_decision")


func trivalent_decision(node_name, input_data, weight_1, weight_2, weight_3, output1, output2, output3):
	var prevalent = max(max(weight_1,weight_2),weight_3)
	#prevalent will be the stronger weight
	if prevalent == weight_1:
		emmit_from_port(1, input_data)
	elif prevalent == weight_2:
		emmit_from_port(2, input_data)
	elif prevalent == weight_3:
		emmit_from_port(3, input_data)
