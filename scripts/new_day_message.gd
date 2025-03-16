extends ColorRect 

@onready var player = get_node("/root/Game/Player")
@onready var dialogue = ""
@onready var button = get_node("/root/Game/CanvasLayer/NextDayButton") 

func _ready(): 
	get_viewport().size_changed.connect(center_dialogue_box) 
	visible = false
	GameManager.next_day.connect(_next_day_started)
	GameManager.game_end.connect(_end_game) 
	
	var text = "\nYou are a young boy in a small village nestled in the rugged mountains of the Sierra 
	Nevada in Spain. Once thriving, the land now struggles under the weight 
	of climate change—rivers run dry, soil loses its richness, and the wildlife 
	fades. The villagers look to you for help. Speak with them, learn their struggles,
	and take action to restore balance to the land. Each day, you have 5 Action Points
	—but choose wisely. You can’t do everything.
	Once you have completed your daily tasks, click \"Next Day\" at the top to proceed."
	text += "\n🌤 *Today's Weather Forecast:* " + GameManager.weather_conditions[GameManager.prev_weather] + "."
	text += "\n🌦 *Tomorrow's Prediction:* " + GameManager.weather_conditions[GameManager.weather] + "."
	open_dialogue("Welcome to the Sierra Revival!" + text + "\nPress q to begin your journey.") 

func generate_day_text() -> String: 
	var text = "\n🌿 *Daily Report* 🌿\n"
	text += "\n🌱 *Biodiversity:* " + describe_biodiversity(GameManager.biodiversity)
	text += "\n💧 *Water Supply:* " + describe_water(GameManager.water)
	text += "\n🌾 *Soil Quality:* " + describe_soil(GameManager.soil_quality)
	if GameManager.day - GameManager.last_water > 1 and GameManager.water < 0:
			text += "\nCommunity members are complaining about the degradation of the irrigation channel."
	if GameManager.tree_planted == 0 and GameManager.tree2_planted == 0 and GameManager.biodiversity < 0:
			text += "\nCommunity members are worried about the lack of new trees in the area."
	if GameManager.dry_soil:
			text += "\nThe failing irrigation system has lead to a dry and dusty soil, 
			dramatically lowering soil quality and harming biodiversity."
	text += "\n🌤 *Today's Weather:* " + GameManager.weather_conditions[GameManager.prev_weather] + "."
	text += "\n🌦 *Tomorrow's Forecast:* " + GameManager.weather_conditions[GameManager.weather] + "."
	return text 

func generate_end_text() -> String: 
	var text = "\n🌅 *Final Ecosystem Report* 🌅\n"
	text += "\n🌱 *Biodiversity:* " + describe_biodiversity(GameManager.biodiversity)
	text += "\n💧 *Water Supply:* " + describe_water(GameManager.water)
	text += "\n🌾 *Soil Quality:* " + describe_soil(GameManager.soil_quality)
	text += "\n🏞 Your journey has come to an end. How well did you protect the ecosystem?"
	return text 

func describe_biodiversity(value: int) -> String:
	if value >= 3:
		return "Thriving 🌿 - A wide range of species flourish in the region."
	elif value >= 0:
		return "Stable 🌾 - The ecosystem is holding strong, but could be improved."
	elif value >= -3:
		return "Struggling 🍂 - Wildlife is scarce, and the ecosystem is fragile."
	else:
		return "Collapsing ☠️ - Most species have disappeared, and the land is barren."

func describe_water(value: int) -> String:
	if value >= 4:
		return "Abundant 💦 - Rivers flow strong, and crops grow well."
	elif value >= 0:
		return "Moderate 🚰 - Water is available but should be managed carefully."
	elif value >= -3:
		return "Scarce 🌵 - Drought conditions are developing. Conservation is needed."
	else:
		return "Critical ❌ - The land is dry and uninhabitable."

func describe_soil(value: int) -> String:
	if value >= 4:
		return "Rich 🌱 - The soil is fertile and full of nutrients."
	elif value >= 0:
		return "Decent 🌿 - Crops can grow, but some areas need care."
	elif value >= -3:
		return "Depleted 🌾 - The land is dry, and farming is difficult."
	else:
		return "Barren 🏜 - Nothing can grow here anymore."

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
