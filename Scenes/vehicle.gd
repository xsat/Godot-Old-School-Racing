extends Node2D

class_name Vehicle

@export var color: Color

@onready var body: ColorRect = $Area2D/Body
@onready var animated_sprite_2d = $Area2D/AnimatedSprite2D

signal area_entered

func get_width() -> float:
	return body.size.x

func get_half_heigth() -> float:
	return body.size.y / 2

func _ready() -> void:
	body.color = color

#func move_x(delta: float) -> void:
	#move_local_x(delta)
	#
	#if global_position.x + body.size.x <= 0:
		#global_position.x = 1000

func _on_area_entered(_area: Area2D):
	area_entered.emit()
