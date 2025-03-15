extends Node

# Evaluation metrics
var biodiversity: int = 0
var soil_quality: int = 0
var livestock: int = 0

# Environmental variables
var weather: int = 0
var water: int = 0

# STATES
var hasWater: int = 0

var day: int = 1
var action_points: int = 5

signal game_start
signal next_day
signal game_end

@export var total_days: int = 5

func _ready() -> void:
	print("Game Start!")
	game_start.emit()

func next_level():
	if day > 5:
		print("End Game")
		
	day += 1
	next_day.emit()
	print("Day:", day)
	action_points = 5
