extends Node

#Class that manages all file interactions, including reading and writing to files and dragging and dropping files into the application.

var importer = EditorSceneImporterGLTF.new()

func _ready():
	get_tree().connect("files_dropped", self, "_on_files_dropped")
		
func load_gltf(path):
	importer

func _on_files_dropped(files : PoolStringArray, from):
	print("Files dropped: ", files, " from: ", from)
	var supported_files = []
	#Check if the file is a .gltf file
	for file in files:
		if file.ends_with(".gltf"):
			supported_files.append(file)
	#If the file is a .gltf file, load it
	if supported_files.size() > 0:
		supported_files = load_gltf(supported_files[0])
