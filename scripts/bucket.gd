extends Node2D 

@export var interaction_distance: float = 100.0 # Adjust based on your game 
@export var cost: int = 2
@export var action_description: String = "You can spend 2 AP to carry water from the well 
to the crops, keeping them healthy, reducing the risk of 
infestations and disease, and enriching the soil."

@onready var player = get_node("/root/Game/Player")
@onready var action_box = get_node("/root/Game/CanvasLayer/ActionBox")
@onready var dialogue_box = get_node("/root/Game/CanvasLayer/DialogueBox")  

var interacted: bool = false

func _ready(): 
	$InteractionIcon.visible = false
	GameManager.next_day.connect(_next_day_started) 
	$AnimatedSprite2D.play("empty")

func _next_day_started(): 
	interacted = false 
	$AnimatedSprite2D.play("empty")
	
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
	$AnimatedSprite2D.play("full")
	if interacted: 
		return  
		
	GameManager.action_points -= cost 
	GameManager.soil_quality += 3
	GameManager.biodiversity += 1
	GameManager.water -= 2
 
	interacted = true 
 
