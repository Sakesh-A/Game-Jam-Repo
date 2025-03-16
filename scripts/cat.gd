extends Node2D 

@export var interaction_distance: float = 100.0 
@export var cost: int = 1 
@export var action_description: String = "Hello, I am a cat! I cost "  

@onready var player = get_node("/root/Game/Player")
@onready var action_box = get_node("/root/Game/CanvasLayer/ActionBox")
@onready var dialogue_box = get_node("/root/Game/CanvasLayer/DialogueBox") 

func _ready(): 
	$InteractionIcon.visible = false 
	$AnimatedSprite2D.play("cat")
	
func _process(_delta: float) -> void: 

	if global_position.distance_to(player.global_position) < interaction_distance: 
		$InteractionIcon.visible = true
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
		$InteractionIcon.visible = false
  

func _action():
	GameManager.action_points -= cost 
