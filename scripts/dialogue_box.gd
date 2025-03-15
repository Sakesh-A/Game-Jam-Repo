extends ColorRect

@onready var player = get_node("/root/Game/Player") # Get the player automatically
@onready var dialogue_label = $DialogueText # Get the Label inside the DialogueBox

var can_close = false # Prevents instant closing

func _ready():
	get_viewport().size_changed.connect(center_dialogue_box) # Update when window resizes
	visible = false  # Start hidden

func _process(delta):
	center_dialogue_box()
	if visible and can_close and Input.is_action_just_pressed("interact"): 
		close_dialogue()

func center_dialogue_box():
	# Get the viewport size
	var screen_size = get_viewport_rect().size
	# Center the dialogue box
	position = (screen_size / 2) - (size / 2)

func open_dialogue(dialogue_text: String):
	dialogue_label.text = dialogue_text # Set unique NPC dialogue
	visible = true
	can_close = false # Prevent immediate closing
	await get_tree().create_timer(0.2).timeout # Small delay before allowing close
	can_close = true # Now, the player can close the dialogue

	if player:
		player.set_process(false) # Disable player movement

func close_dialogue():
	visible = false
	can_close = false # Reset for the next interaction
	if player:
		player.set_process(true)  # Re-enable player movement
