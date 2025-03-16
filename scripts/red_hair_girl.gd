extends StaticBody2D 

@export var interaction_distance: float = 100.0 
@export var npc_dialogue: String = "Sofia: “You ever notice how quiet it’s gotten around here?” 
									Marcos: “What do you mean? I still hear the birds” 									
									Sofia: “Not as many as before. A lot of trees have been lost
									and with them, the things that lived in them.” 
									Marcos: “I guess I never thought about that.” \n
									Press q to close window"

@onready var player = get_node("/root/Game/Player") 
@onready var dialogue_box = get_node("/root/Game/CanvasLayer/DialogueBox")

func _ready(): 
	$InteractionIcon.visible = false

func _process(_delta: float) -> void: 
	$AnimatedSprite2D.play("idle") 
	var direction = global_position.direction_to(player.global_position) 

	if direction.x > 0: 
		$AnimatedSprite2D.flip_h = false 
	elif direction.x < 0: 
		$AnimatedSprite2D.flip_h = true 

	if global_position.distance_to(player.global_position) < interaction_distance: 
		$InteractionIcon.visible = true
		$InteractionIcon.play("default") 
	 
		# Check for "interact" input 
		if Input.is_action_just_pressed("interact"):
			dialogue_box.open_dialogue(npc_dialogue, get_path())
	else: 
		$InteractionIcon.visible = false
	 
