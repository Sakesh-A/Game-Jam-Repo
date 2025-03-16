extends StaticBody2D 

@export var interaction_distance: float = 100.0
@export var npc_dialogue: String = "Well now, buen día Young man, 
You know, the winters here used to  
be longer with more snow. 
Now, it melts too soon and the rivers  
run dry before summer’s even begun 
The farmers struggle, the animals wander 
lower for water. The mountains remember, 
even if we choose to forget.\n 
Press q to close the window" 

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
	 
