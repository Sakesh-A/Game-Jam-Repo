extends Node2D 

@export var interaction_distance: float = 100.0
@export var cost: int = 2
@export var action_description: String = "Hello, I am a bag of tree seeds! I cost "

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
	 
	# Check for "interact" input 
		if Input.is_action_just_pressed("interact"):
			var action_text = action_description + str(cost) + "\n You have this many AP points: " + str(GameManager.action_points) 
			if GameManager.action_points < cost:
				action_text += "\n Not enough points to buy"
				dialogue_box.open_dialogue(action_text, get_path())
			else:
				action_text += "\n Press E to buy" 
				action_box.open_action(action_text, get_path())
	else:
		$InteractionIcon.visible = false
  

func _action(): 
	$AnimatedSprite2D.play("hole")
	if interacted: 
		return  

	GameManager.action_points -= cost 
	GameManager.soil_quality += 2
	GameManager.water -= 2
	GameManager.biodiversity += 2
	GameManager.tree_planted = 1
 
	interacted = true 
 
