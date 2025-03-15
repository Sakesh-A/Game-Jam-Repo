extends StaticBody2D

@onready var waterfall_sprite = $AnimatedSprite2D
var growth_stage = 0
var max_stages = 4
var change_time = 0.25

func _ready():
	start_growth_cycle()

func start_growth_cycle():
	var timer = Timer.new()
	timer.wait_time = change_time
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_grow)
	add_child(timer)

func _grow():
	growth_stage = (growth_stage + 1) % max_stages
	waterfall_sprite.frame = growth_stage
