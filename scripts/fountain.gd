extends StaticBody2D

@export var interaction_distance: float = 100.0
@export var cost: int = 3
@export var action_description: String = "You can spend 3 AP to build a bird fountain,
which can attract native birds and insects."

@onready var player = get_node("/root/Game/Player")
@onready var action_box = get_node("/root/Game/CanvasLayer/ActionBox")
@onready var dialogue_box = get_node("/root/Game/CanvasLayer/DialogueBox") 

var interacted: bool = false 

func _ready(): 
	$InteractionIcon.visible = false
	$Hammer.visible = true
	$Fountain.visible = false
	
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
	$Hammer.visible = false
	$Fountain.visible = true
	if interacted: 
		return  

	GameManager.action_points -= cost 
	GameManager.soil_quality += 1
	GameManager.water -= 1
	GameManager.biodiversity += 4
	GameManager.fountain_built = true
 
	interacted = true 
 
