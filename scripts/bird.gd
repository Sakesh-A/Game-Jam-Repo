extends StaticBody2D

@onready var fountain = get_node("/root/Game/Fountain")

func _ready(): 
	visible = false
	GameManager.next_day.connect(_next_day)

func _next_day() -> void:
	if GameManager.fountain_built:
		if GameManager.biodiversity > 3:
			visible = true
			$AnimatedSprite2D.play("default")
		elif GameManager.biodiversity > 0:
			var change = randi_range(-2, 2) 
			if change >= 1:
				visible = true
				$AnimatedSprite2D.play("default")
			else:
				visible = false
	else:
		visible = false
