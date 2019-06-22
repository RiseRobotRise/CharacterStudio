extends Node

var actions = [
	preload("res://Nodes/Actions/Go_to.tscn"), 
	preload("res://Nodes/Actions/Shoot.tscn"),
	preload("res://Nodes/Actions/Flee.tscn"),
	preload("res://Nodes/Actions/Play_sound.tscn")
	]
	
var stimulus = [
	preload("res://Nodes/Stimulus/Damaged.tscn"),
	preload("res://Nodes/Stimulus/Onsight.tscn"),
	preload("res://Nodes/Stimulus/Hear.tscn"),
	preload("res://Nodes/Stimulus/Visuals.tscn"),
	preload("res://Nodes/Stimulus/Smell.tscn")
	]
	
var inhibitors = [
	preload("res://Nodes/Inhibitors/Decision.tscn"), 
	preload("res://Nodes/Inhibitors/Preservation.tscn")
	]
var misc = [ 
	preload("res://Nodes/Misc/Math.tscn"),
	preload("res://Nodes/Misc/Parallel.tscn")
	]

const VECTOR = Color(0.5,0.2,0.2,1)
const INT = Color(0.8,0.3,1,1)
const BOOL = Color(1,1,1,1)
const FLOAT = Color(0,1,0,1)
const ARRAY = Color(0.7,0.2,0.0,1.0)
const NIL = Color(0,0,0,1)