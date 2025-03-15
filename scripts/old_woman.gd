extends StaticBody2D

@export var interaction_distance: float = 100.0 # Adjust based on your game
@export var npc_dialogue: String = "Hello, traveler! I am an old woman.\n
We need to disable player movement when this window appears and offer two buttons to make a decision" # Unique dialogue per NPC

@onready var player = get_node("/root/Game/Player")
@onready var dialogue_box = get_node("/root/Game/CanvasLayer/DialogueBox") # Get the dialogue box node

func _ready():
	$InteractionIcon.visible = false # Hide the indicator initially

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.play("idle")
	var direction = global_position.direction_to(player.global_position)

	if direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction.x < 0:
		$AnimatedSprite2D.flip_h = true

	# Check if the player is within interaction range
	if global_position.distance_to(player.global_position) < interaction_distance:
		$InteractionIcon.visible = true # Show indicator
		$InteractionIcon.play("default")
		
		# Check for "interact" input
		if Input.is_action_just_pressed("interact"):
			dialogue_box.open_dialogue(npc_dialogue) # Pass unique NPC text
	else:
		$InteractionIcon.visible = false # Hide indicator
