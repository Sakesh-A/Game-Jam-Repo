extends Node2D 

@export var interaction_distance: float = 100.0
@export var cost: int = 2
@export var action_description: String = "This is a bag of tree seeds. You can spend 2 AP 
to plant these seeds, which may help provide shelter and 
food to local fauna and improve the soil."

@onready var player = get_node("/root/Game/Player")
@onready var action_box = get_node("/root/Game/CanvasLayer/ActionBox")
@onready var dialogue_box = get_node("/root/Game/CanvasLayer/DialogueBox") 

var interacted: bool = false 

func _ready(): 
	$InteractionIcon.visible = false
	$AnimatedSprite2D.play("seeds")
	
func _process(_delta: float) -> void:
	if GameManager.tree_planted == 3:
		visible = false
		
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
	$AnimatedSprite2D.play("hole")
	if interacted: 
		return  

	GameManager.action_points -= cost 
	GameManager.soil_quality += 2
	GameManager.water -= 1
	GameManager.biodiversity += 2
	GameManager.tree_planted = 1
 
	interacted = true 
 
