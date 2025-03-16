extends StaticBody2D 

@export var interaction_distance: float = 100.0
@export var npc_dialogue: String = "Marcos: “Hey, Isabel, the fields look drier than last year.” 
									Isabel: “The irrigation ditches aren’t being maintained like
											they should be”
									Marcos: “Can’t they just clear them out once in a while?”
									Isabel: “Someone should be checking them every day
											 ‘Once in a while’ isn’t enough”\n
									Press q to close window" # Unique dialogue per NPC 

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
	 
