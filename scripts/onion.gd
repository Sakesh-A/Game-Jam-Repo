extends StaticBody2D

@onready var onion_sprite = $AnimatedSprite2D
var growth_stage = 0
var max_stages = 6
var growth_time = 1.0 

func _ready():
	start_growth_cycle()

func start_growth_cycle():
	var timer = Timer.new()
	timer.wait_time = growth_time
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_grow)
	add_child(timer)
	
func _grow():
	growth_stage = (growth_stage + 1) % max_stages 
	onion_sprite.frame = growth_stage
	
