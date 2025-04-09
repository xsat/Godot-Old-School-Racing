extends Node2D

class_name Road

@onready var body: ColorRect = $Body

func get_width() -> float:
	return body.size.x
