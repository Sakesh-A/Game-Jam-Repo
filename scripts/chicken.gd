extends StaticBody2D

@export var flip_interval: float = 2.0

func _ready():
	$AnimatedSprite2D.play("default")
	visible = true
	randomize()
	start_flipping()

func start_flipping():
	var timer = Timer.new()
	timer.wait_time = flip_interval
	timer.autostart = true
	timer.one_shot = false
	timer.connect("timeout", _on_flip_timer_timeout)
	add_child(timer)
	GameManager.next_day.connect(_next_day)
	
func _next_day():
	if GameManager.water < 0 or GameManager.soil_quality < 0 or GameManager.biodiversity < 0:
		randomize() 
		var change = randi_range(-2, 2) 
		if change == -2:
			visible = false
	else:
		randomize() 
		var change = randi_range(-2, 2) 
		if change >= 1:
			visible = true

func _on_flip_timer_timeout():
	if randi() % 2 == 0:
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
