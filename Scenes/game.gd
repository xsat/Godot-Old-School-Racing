extends Control

class_name Game

@onready var first_road: Road = $Road/FirstRoad
@onready var second_road: Road = $Road/SecondRoad
@onready var last_road: Road = second_road

@onready var player_vehicle: Vehicle = $Road/PlayerVehicle
@onready var trafic_vehicle_0: Vehicle = $Road/TraficVehicle0
@onready var trafic_vehicle_1: Vehicle = $Road/TraficVehicle1
@onready var trafic_vehicle_2: Vehicle = $Road/TraficVehicle2
@onready var trafic_vehicle_3: Vehicle = $Road/TraficVehicle3
@onready var last_vehicle: Vehicle = trafic_vehicle_3

@onready var move_top: Move = $Road/MoveTop
@onready var move_bot: Move = $Road/MoveBot

@onready var score: Score = $Score

@onready var overlay: ColorRect = $Overlay

var _max_level: int = 100
var _player_level: int = 1
var _cof: int = 10

var _player_miles: float = .00

var _levels_map: Dictionary = {}
var _is_game_over = false

var _rng = RandomNumberGenerator.new()

func _ready() -> void:
	move_top.move_pressed.connect(_on_move_pressed)
	move_bot.move_pressed.connect(_on_move_pressed)
	player_vehicle.area_entered.connect(_on_area_entered)
	
	for i in range(1, 101):
		if i == 1:
			_levels_map[i] = _cof
		else:
			_levels_map[i] = (_cof * i) +  _levels_map[i-1]
			
	_reset_vehicles()
	
func _process(delta: float) -> void:
	if _is_game_over:
		return
	
	var speed: float = _player_level * 100
	
	first_road.move_local_x(-(speed * delta))
	second_road.move_local_x(-(speed * delta))
	
	_player_miles += (speed * delta) / 100
	if _player_level < _max_level and _player_miles >= _levels_map[_player_level]:
		_player_level += 1
	
	score.update_score_from_player_miles(_player_miles)
	
	if last_road.global_position.x <= 0:
		if last_road.get_instance_id() == second_road.get_instance_id():
			first_road.global_position.x = last_road.global_position.x + last_road.get_width()
			last_road = first_road
		elif last_road.get_instance_id() == first_road.get_instance_id():
			second_road.global_position.x = last_road.global_position.x + last_road.get_width()
			last_road = second_road
	#
	trafic_vehicle_0.move_local_x(-(speed * delta))
	trafic_vehicle_1.move_local_x(-(speed * delta))
	trafic_vehicle_2.move_local_x(-(speed * delta))
	trafic_vehicle_3.move_local_x(-(speed * delta))
	
	_calc_next_verhicle(trafic_vehicle_0)
	_calc_next_verhicle(trafic_vehicle_1)
	_calc_next_verhicle(trafic_vehicle_2)
	_calc_next_verhicle(trafic_vehicle_3)
		
func _calc_speed(player_level: int) -> float:
	return player_level * 100
	
func _calc_next_verhicle(verhicle: Vehicle)-> void:
	if verhicle.global_position.x + verhicle.get_width() <= 0:
		var last_vehicle_position_x = last_vehicle.global_position.x + last_vehicle.get_width() + last_vehicle.get_width() + 50
		
		verhicle.global_position.x = randi_range(last_vehicle_position_x, last_vehicle_position_x + 1000)
		if _rng.randi_range(0, 1) == 0:
			verhicle.position.y = move_top.position.y + verhicle.get_half_heigth()
			verhicle.animated_sprite_2d.flip_h = true
		else:
			verhicle.position.y = move_bot.position.y + verhicle.get_half_heigth()
			verhicle.animated_sprite_2d.flip_h = false
			
		last_vehicle = verhicle
		
func _on_move_pressed(move_pressed: Move) -> void:
	if not _is_game_over:
		player_vehicle.position.y = move_pressed.position.y + player_vehicle.get_half_heigth()

func _on_area_entered() -> void:
	_is_game_over = true
	overlay.visible = true

func _on_reset_pressed() -> void:
	get_tree().reload_current_scene()

func _on_buy_pressed() -> void:
	overlay.visible = false
	
	_reset_vehicles()
	
	_is_game_over = false
	
	score.update_score_color_to_premium()

func _reset_vehicles() -> void:
	last_vehicle.global_position.x = get_window().size.x
	
	trafic_vehicle_0.global_position.x = -trafic_vehicle_0.get_width()
	_calc_next_verhicle(trafic_vehicle_0)
	
	trafic_vehicle_1.global_position.x = -trafic_vehicle_1.get_width()
	_calc_next_verhicle(trafic_vehicle_1)
	
	trafic_vehicle_2.global_position.x = -trafic_vehicle_2.get_width()
	_calc_next_verhicle(trafic_vehicle_2)
	
	trafic_vehicle_3.global_position.x = -trafic_vehicle_3.get_width()
	_calc_next_verhicle(trafic_vehicle_3)
