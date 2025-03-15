extends ProgressBar
var cur_stock: float = 0.0
var max_stock: float = 90.0

func _ready():
	set_progress(max_stock)

func set_progress(value: float):
	cur_stock = clamp(value, 0, max_stock) 
	self.value = cur_stock 

func increase_progress(amount: float):
	set_progress(cur_stock + amount)

func reset_progress():
	set_progress(0)
