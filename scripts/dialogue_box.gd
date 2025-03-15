extends ColorRect

@onready var player = get_node("/root/Game/Player") # Get the player automatically
@onready var dialogue = "" # Get the Label inside the DialogueBox
@onready var dialogue_path = ""  # Store path as a string, not a node.

func _ready():
	get_viewport().size_changed.connect(center_dialogue_box) # Update when window resizes
	visible = false  # Start hidden

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
		player.set_process(true)  # Re-enable player movement
