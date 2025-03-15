extends Node2D

@export var interaction_distance: float = 100.0 # Adjust based on your game
@export var cost: int = 3
@export var action_description: String = "Hello, I am a shovel! I cost " # Unique dialogue per NPC

@onready var player = get_node("/root/Game/Player")
@onready var action_box = get_node("/root/Game/CanvasLayer/ActionBox") # Get the dialogue box node
@onready var dialogue_box = get_node("/root/Game/CanvasLayer/DialogueBox") # Get the dialogue box node

var interacted: bool = false  # Track if the object has already been used

func _ready():
	$InteractionIcon.visible = false # Hide the indicator initially
	GameManager.next_day.connect(_next_day_started)

func _next_day_started():
	interacted = false
	cost = 2

func _process(_delta: float) -> void:
	# If already interacted, disable further interaction
	if interacted:
		$InteractionIcon.visible = false
		return  

	# Check if the player is within interaction range
	if global_position.distance_to(player.global_position) < interaction_distance:
		$InteractionIcon.visible = true # Show indicator
		$InteractionIcon.play("default")
		
		# Check for "interact" input
		if Input.is_action_just_pressed("interact"):
			var action_text = action_description + str(cost) + "\n You have this many AP points: " + str(GameManager.action_points)
			if GameManager.action_points < cost:
				action_text += "\n Not enough points to buy"
				dialogue_box.open_dialogue(action_text, get_path())
			else:
				action_text += "\n Press E to buy"
				action_box.open_action(action_text, get_path()) # Pass the _action function as a callback
	else:
		$InteractionIcon.visible = false # Hide indicator

func _action():
	# Ensure action is performed only once
	if interacted:
		return  

	GameManager.action_points -= cost
	GameManager.soil_quality += 3
	GameManager.hasWater += 1

	# Mark as interacted and disable future interactions
	interacted = true
