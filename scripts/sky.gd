extends CanvasLayer

func _ready():
	visible = false
	GameManager.next_day.connect(_next_day)
	
func _next_day():
	$LightRain.visible = false
	$HeavyRain.visible = false
	$Dry.visible = false
	$Drought.visible = false
	$GPUParticles2D.visible = true
	if GameManager.weather == -1:
		$LightRain.visible = true
		$GPUParticles2D.visible = true
	elif GameManager.weather == -2:
		$HeavyRain.visible = true
		$GPUParticles2D.visible = true
	elif GameManager.weather == 1:
		$Dry.visible = true
	else:
		$Drought.visible = true
