extends StaticBody2D

func _ready() -> void:
	visible = false
	
func _process(_delta: float) -> void:
	if GameManager.tree2_planted >= 3:
		visible = true
		if GameManager.soil_quality > 0 and GameManager.water > 0:
			$AnimatedSprite2D.play("live")
		else:
			$AnimatedSprite2D.play("dead")
