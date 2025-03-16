extends StaticBody2D

var growth_stage = 0

func _ready():
	visible = true
	$AnimatedSprite2D.play("0")
	GameManager.next_day.connect(_next_day)
	
func _next_day():
	if GameManager.water > 0 and GameManager.soil_quality > 0:
		var change = randi_range(1, 2) 
		growth_stage += change
	if growth_stage > 0 and growth_stage < 5:
		$AnimatedSprite2D.play(str(growth_stage))
	elif growth_stage <= 0:
		$AnimatedSprite2D.play("0")
	else:
		$AnimatedSprite2D.play("5")
