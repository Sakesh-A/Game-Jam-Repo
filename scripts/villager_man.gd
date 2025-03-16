extends StaticBody2D 

@export var interaction_distance: float = 100.0
@export var npc_dialogue: String = "Look at these poor plants. 
The leaves are curling up, turning brown
at the edges. They’re thirsty
It didn’t used to be like this.
See that pail over there?
We can bring them some water.
It won’t fix everything, but it’s a start.\n
Press q to close window." 

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
	 
