extends StaticBody2D

func _ready(): 
	visible = true
	GameManager.next_day.connect(_next_day_started) 
	$AnimatedSprite2D.play("live")

func _next_day_started(): 
	if GameManager.water < 0 or GameManager.soil_quality < 0 or GameManager.biodiversity < 0:
		randomize() 
		var change = randi_range(-2, 2) 
		if change == -2:
			$AnimatedSprite2D.play("dead")
	else:
		randomize() 
		var change = randi_range(-2, 2) 
		if change >= 1:
			$AnimatedSprite2D.play("live")
