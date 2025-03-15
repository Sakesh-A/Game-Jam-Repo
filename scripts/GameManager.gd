extends Node

# Evaluation metrics
var biodiversity: int = 0
var soil_quality: int = 0
var water: int = 0

# Environmental variables
var weather: int = 0
var prev_weather: int = 0

var day: int = 1
var action_points: int = 5

signal game_start
signal next_day
signal game_end

var weather_conditions = {
	-2: "Drought",
	-1: "Dry",
	0: "Normal",
	1: "Light Rain",
	2: "Rainy",
}

@export var total_days: int = 5

func _ready() -> void:
	print("Game Start!")
	game_start.emit()

func next_level():
	if day > 5:
		print("End Game")
		game_end.emit()
		
	day += 1
	next_day.emit()
	print("Day:", day)
	action_points = 5
	
	biodiversity -= 1
	soil_quality -= 1
	water -= 1
	
	prev_weather = weather
	update_weather()
	
func update_weather():
	# Randomly adjust weather by -1, 0, or +1 (keeping it within range)
	randomize()
	var change = randi_range(-2, 2)
	if change == -2:
		change = -1
	elif change == 2:
		change = 1
	weather = clamp(weather + change, -2, 2)
	
	print("Weather:", weather_conditions.get(weather, "Unknown"))
	
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
