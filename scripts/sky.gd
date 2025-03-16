extends CanvasLayer

@onready var node = get_node("../CanvasLayer/GPUParticles2D")

func _ready():
	visible = false
	GameManager.next_day.connect(_next_day)
	node.visible = false
	
func _next_day():
	$LightRain.visible = false
	$HeavyRain.visible = false
	$Dry.visible = false
	$Drought.visible = false
	node.visible = false
	if GameManager.weather == 1:
		$LightRain.visible = true
		node.visible = true
	elif GameManager.weather == 2:
		$HeavyRain.visible = true
		node.visible = true
	elif GameManager.weather == -1:
		$Dry.visible = true
	else:
		$Drought.visible = true
