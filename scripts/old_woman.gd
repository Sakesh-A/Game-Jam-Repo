extends StaticBody2D 

@export var interaction_distance: float = 100.0
@export var npc_dialogue: String = "Hello, traveler! I am a farmer.\n We need to disable player movement when this window appears and offer two buttons to make a decision" # Unique dialogue per NPC 

@onready var player = get_node("/root/Game/Player") 
@onready var dialogue_box = get_node("/root/Game/CanvasLayer/DialogueBox")

func _ready(): 
	$InteractionIcon.visible = false

func _process(_delta: float) -> void: 
	$AnimatedSprite2D.play("idle") 
	var direction = global_position.direction_to(player.global_position) 

	# AI citation: ChatGPT second row in the table
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
	 
