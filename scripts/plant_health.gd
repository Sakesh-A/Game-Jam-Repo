extends ProgressBar
var cur_plant: float = 75.0
var max_plant: float = 100.0

func _ready():
	set_progress(max_plant)

func set_progress(value: float):
	cur_plant = clamp(value, 0, max_plant) 
	self.value = cur_plant 

func increase_progress(amount: float):
	set_progress(cur_plant + amount)

func reset_progress():
	set_progress(0)
