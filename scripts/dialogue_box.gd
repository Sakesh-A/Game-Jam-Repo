extends ColorRect 

@onready var player = get_node("/root/Game/Player")
@onready var dialogue = ""
@onready var dialogue_path = ""
@onready var dialogue_label = $DialogueText

func _ready(): 
	get_viewport().size_changed.connect(center_dialogue_box)
	#dialogue_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER # Center-align horizontally
	#dialogue_label.vertical_alignment = VERTICAL_ALIGNMENT_TOP # Center-align vertically
	
	#dialogue_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	#dialogue_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	#color = Color(0.1, 0.2, 0.5, 0.8)
	visible = false  # Start hidden

	#size = Vector2(400, 200)
	dialogue_label.custom_minimum_size = Vector2(280, 80)
	#dialogue_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

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

 
