extends Control

class_name Move

signal move_pressed(move: Move)

@onready var button: Button = $Button

func _on_button_pressed() -> void:
	move_pressed.emit(self)
