class_name Level extends Node

const LEVEL_COMPLETE = "res://Scenes/level_complete.tscn"

var num_level:int


func finish_level():
	var level_complete = preload(LEVEL_COMPLETE).instantiate()
	add_child(level_complete)
