extends Label

class_name Score

#const _SCORE_VALUE_SAVE_PATH: String = "user://score_value.save"

func update_score_from_player_miles(player_miles: float) -> void:
	text = str(roundi(player_miles))

func update_score_color_to_premium() -> void:
	add_theme_color_override("font_color", Color.YELLOW)

#func _save_value() -> void:
	#var json_string: String = JSON.stringify(_player_miles)
	#var score_value_file: FileAccess = FileAccess.open(SCORE_VALUE_SAVE_PATH, FileAccess.WRITE)
	#score_value_file.store_line(json_string)
	#score_value_file.close()
	#
#func _load_value() -> void:
	#if FileAccess.file_exists(SCORE_VALUE_SAVE_PATH):
		#var score_value_file: FileAccess = FileAccess.open(SCORE_VALUE_SAVE_PATH, FileAccess.READ)
		#var player_miles: float = float(JSON.parse_string(score_value_file.get_line()))
		#update_player_miles(player_miles, false)
		#score_value_file.close()
