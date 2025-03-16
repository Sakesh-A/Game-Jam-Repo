extends ColorRect 

@onready var player = get_node("/root/Game/Player")
@onready var dialogue = ""
@onready var dialogue_path = ""

func _ready(): 
	get_viewport().size_changed.connect(center_dialogue_box)
	visible = false

func _process(_delta): 
	center_dialogue_box() 
	if visible and Input.is_action_just_pressed("close_dialogue"): 
		close_dialogue() 

func center_dialogue_box():
	var screen_size = get_viewport_rect().size
	position = (screen_size / 2) - (size / 2) 

func open_dialogue(dialogue_text: String, _path: String):
	$DialogueText.text = dialogue_text 
	visible = true 

func close_dialogue(): 
	visible = false 
	if player: 
		player.set_process(true)

 
