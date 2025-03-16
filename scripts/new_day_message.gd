extends ColorRect 

@onready var player = get_node("/root/Game/Player")
@onready var dialogue = ""
@onready var button = get_node("/root/Game/CanvasLayer/NextDayButton") 

func _ready(): 
	get_viewport().size_changed.connect(center_dialogue_box) 
	visible = false
	GameManager.next_day.connect(_next_day_started)
	GameManager.game_end.connect(_end_game) 
	var text = "" 
	text += "\nThe weather forcast is " + GameManager.weather_conditions[GameManager.prev_weather] + " for today" 
	text += "\nThe weather is predicted to be " + GameManager.weather_conditions[GameManager.weather] + "tomorrow" 
	open_dialogue("Welcome to our game!\n Press q to close this message and begin the game!" + text) 

func generate_day_text() -> String: 
	var text = "" 
	text += "Biodiversity level: " + str(GameManager.biodiversity) 
	text += "\nWater level: " + str(GameManager.water) 
	text += "\nSoil quality: " + str(GameManager.soil_quality) 
	text += "\nThe weather forcast is " + GameManager.weather_conditions[GameManager.prev_weather] + " for today" 
	text += "\nThe weather is predicted to be " + GameManager.weather_conditions[GameManager.weather] + "tomorrow" 
	return text 

func generate_end_text() -> String: 
	var text = "" 
	text += "Biodiversity level: " + str(GameManager.biodiversity) 
	text += "\nWater level: " + str(GameManager.water) 
	text += "\nSoil quality: " + str(GameManager.soil_quality)  
	return text 

func _next_day_started():
	open_dialogue(generate_day_text()) 

func _end_game(): 
	open_dialogue(generate_end_text())

func _process(_delta): 
	center_dialogue_box() 
	if Input.is_action_just_pressed("close_dialogue"): 
		close_dialogue() 

func center_dialogue_box(): 
	var screen_size = get_viewport_rect().size 
	position = (screen_size / 2) - (size / 2) 

func open_dialogue(day_text: String): 
	$DayText.text = day_text 
	visible = true 
	button.visible = false 

func close_dialogue(): 
	visible = false 
	button.visible = true
	if GameManager.game_ended:
		get_tree().quit()
