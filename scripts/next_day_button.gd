extends Button 

func _ready() -> void: 
	visible = false 
func _pressed() -> void: 
	GameManager.next_level() 

 
