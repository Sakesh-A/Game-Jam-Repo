extends ColorRect

func _ready():
	visible = false
	GameManager.next_day.connect(_next_day)
	
func _next_day():
	if GameManager.weather == -2:
		visible = true
	else:
		visible = false
