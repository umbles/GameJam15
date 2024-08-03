extends Label3D

@export var stringArray = ["test123"] 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#set_text(array_to_string(stringArray))
	
	pass
	
func array_to_string(arr: Array) -> String:
	var s = ""
	for i in arr:
		s += String(i)
	return s
	
