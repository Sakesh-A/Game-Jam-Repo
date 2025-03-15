extends ProgressBar
var cur_soil: float = 0.0
var max_soil: float = 100.0

func _ready():
	set_progress(max_soil)

func set_progress(value: float):
	cur_soil = clamp(value, 0, max_soil) 
	self.value = cur_soil 

func increase_progress(amount: float):
	set_progress(cur_soil + amount)

func reset_progress():
	set_progress(0)
