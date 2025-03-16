extends ColorRect 

@onready var player = get_node("/root/Game/Player") # Get the player automatically
@onready var action_label = "" # Get the Label inside the DialogueBox 
@onready var action_path = "" # Store path as a string, not a node. 


func _ready(): 
	get_viewport().size_changed.connect(center_action_box) 
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
	action_path = action # Store the string path 

func close_action(): 
	visible = false 
	if player: 
		player.set_process(true) # Re-enable player movement 

 
