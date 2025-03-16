extends Node 

var biodiversity: int = 0 
var soil_quality: int = 0 
var water: int = 0 
var weather: int = 0 
var prev_weather: int = 0 
var day: int = 1 
var action_points: int = 5 
var tree_planted: int = 0
var tree2_planted: int = 0
var water_maintained: int = 0 
signal next_day 
signal game_end 
var game_ended
var fountain_built: bool = false

var weather_conditions = { 
	-2: "Drought", 
	-1: "Dry", 
	0: "Normal", 
	1: "Light Rain", 
	2: "Rainy", 
} 
@export var total_days: int = 5 

func _ready() -> void: 
	next_day.emit() 

func next_level(): 
	if day > 5: 
		game_end.emit() 
		game_ended = true
		return

	day += 1 
	next_day.emit() 
	action_points = 5 
	biodiversity -= 1 
	soil_quality -= 1 
	water -= 1 
	prev_weather = weather 
	update_weather() 
	if tree_planted > 0:
		tree_planted += 1
	if tree2_planted > 0:
		tree2_planted += 1
	
func update_weather(): 
	randomize() 
	var change = randi_range(-2, 2) 
	if change == -2: 
		change = -1 
	elif change == 2: 
		change = 1 
	weather = clamp(weather + change, -2, 2) 
	
func process_weather(): 
	if weather_conditions[weather] == "Drought": 
		water -= 3 
		soil_quality -= 2 
		biodiversity -= 1 
		
	if weather_conditions[weather] == "Dry": 
		water -= 2 
		soil_quality -= 1 
		
	if weather_conditions[weather] == "Normal": 
		soil_quality += 1 
		biodiversity += 1 

	if weather_conditions[weather] == "Light Rain": 
		water += 3 
		soil_quality += 3 
		biodiversity += 1 

	if weather_conditions[weather] == "Rainy": 
		water += 4 
		soil_quality += 2 
