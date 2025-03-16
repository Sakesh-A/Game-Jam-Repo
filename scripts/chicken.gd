extends StaticBody2D

@export var flip_interval: float = 2.0

func _ready():
	$AnimatedSprite2D.play("default")
	randomize()
	start_flipping()

func start_flipping():
	var timer = Timer.new()
	timer.wait_time = flip_interval
	timer.autostart = true
	timer.one_shot = false
	timer.connect("timeout", _on_flip_timer_timeout)
	add_child(timer)

func _on_flip_timer_timeout():
	if randi() % 2 == 0:
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
