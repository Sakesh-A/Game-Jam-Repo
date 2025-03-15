extends ProgressBar
var cur_water: float = 50.0
var max_water: float = 100.0

func _ready():
	set_progress(cur_water)

func set_progress(value: float):
	cur_water = clamp(value, 0, max_water) 
	self.value = cur_water 

func increase_progress(amount: float):
	set_progress(cur_water + amount)

func reset_progress():
	set_progress(0)
