extends ColorRect 

@onready var player = get_node("/root/Game/Player")
@onready var action_label = ""
@onready var action_path = ""
@onready var dialogue_label = $ActionText


func _ready(): 
	get_viewport().size_changed.connect(center_action_box) 
	#dialogue_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER # Center-align horizontally
	#dialogue_label.vertical_alignment = VERTICAL_ALIGNMENT_TOP # Center-align vertically
	
	#dialogue_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	#dialogue_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	color = Color(0.1, 0.2, 0.5, 0.8)
	visible = false  # Start hidden

	# size = Vector2(400, 200)
	dialogue_label.custom_minimum_size = Vector2(280, 80)
	# dialogue_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	visible = false  

func _process(_delta): 
	center_action_box() 
	if visible and Input.is_action_just_pressed("action"): 
		print("Attempting to call action on:", action_path) 
		var action_node = get_node_or_null(action_path) 
		if action_node: 
			action_node._action() 
		else: 
			print("Error: Node not found at path: " + action_path) 
		close_action() 
	if visible and Input.is_action_just_pressed("close_dialogue"): 
		close_action() 

func center_action_box(): 
	var screen_size = get_viewport_rect().size 
	position = (screen_size / 2) - (size / 2) 

func open_action(action_text: String, action: String):
	$ActionText.text = action_text 
	visible = true 
	action_path = action

func close_action(): 
	visible = false 
	if player: 
		player.set_process(true)

 
