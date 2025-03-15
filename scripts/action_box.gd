extends ColorRect

@onready var player = get_node("/root/Game/Player") # Get the player automatically
@onready var action_label = "" # Get the Label inside the DialogueBox
@onready var action_path = ""  # Store path as a string, not a node.

var can_close = false # Prevents instant closing

func _ready():
	get_viewport().size_changed.connect(center_action_box) # Update when window resizes
	visible = false  # Start hidden

func _process(delta):
	center_action_box()
	if visible and can_close and Input.is_action_just_pressed("interact"):
		close_action()
	if visible and Input.is_action_just_pressed("action"):
		print("Attempting to call action on:", action_path)  # Debugging output
		var action_node = get_node_or_null(action_path)  # Convert path to node
		if action_node:
			action_node._action()
		else:
			print("Error: Node not found at path: " + action_path)  # Debugging output
		close_action()
	if visible and can_close and Input.is_action_just_pressed("close_dialogue"):
		visible = false

func center_action_box():
	var screen_size = get_viewport_rect().size
	position = (screen_size / 2) - (size / 2)

func open_action(action_text: String, action: String):
	$ActionText.text = action_text
	visible = true
	can_close = false
	action_path = action  # Store the string path
	await get_tree().create_timer(0.1).timeout
	can_close = true

func close_action():
	visible = false
	can_close = false
	if player:
		player.set_process(true)  # Re-enable player movement
