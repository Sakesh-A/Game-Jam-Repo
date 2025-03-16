extends Node2D 

@export var interaction_distance: float = 100.0
@export var cost: int = 3 
@export var action_description: String = "You can spend 3 AP to maintain the irrigation channel, 
which helps crops hydrated, prevents soil erosion, 
and supports the village’s water supply."

@onready var player = get_node("/root/Game/Player")
@onready var action_box = get_node("/root/Game/CanvasLayer/ActionBox")
@onready var dialogue_box = get_node("/root/Game/CanvasLayer/DialogueBox")

var interacted: bool = false

func _ready(): 
	$InteractionIcon.visible = false 
	GameManager.next_day.connect(_next_day_started) 

func _next_day_started(): 
	interacted = false 
	
func _process(_delta: float) -> void:
	if interacted: 
		$InteractionIcon.visible = false 
		return  

	if global_position.distance_to(player.global_position) < interaction_distance: 
		$InteractionIcon.visible = true
		$InteractionIcon.play("default") 
	 
		if Input.is_action_just_pressed("interact"): 
			var action_text = action_description + "\nYou have " + str(GameManager.action_points) + " AP." 
			if GameManager.action_points < cost: 
				action_text += "\nNot enough AP to perform action" 
				action_text += "\nPress q to close window " 
				dialogue_box.open_dialogue(action_text, get_path()) 
			else: 
				action_text += "\nPress e to perform action" 
				action_text += "\nPress q to close window "  
				action_box.open_action(action_text, get_path()) 
	else:
		$InteractionIcon.visible = false 
  

func _action():
	if interacted: 
		return  

	GameManager.action_points -= cost 
	GameManager.soil_quality += 1 
	GameManager.water += 3 
 
	interacted = true 
 
