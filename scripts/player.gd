extends CharacterBody2D
@onready var audio = $"../audio"

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * 400
	move_and_slide()

	if velocity.length() > 0.0:
		if abs(direction.x) > abs(direction.y):
			$AnimatedSprite2D.play("walk_h")
			$AnimatedSprite2D.flip_h = direction.x < 0
		elif direction.y < 0:
			$AnimatedSprite2D.play("walk_u")
		else:
			$AnimatedSprite2D.play("walk_d")
	else:
		$AnimatedSprite2D.play("idle")

		
func _ready():
	GameManager.next_day.connect(_next_day_started) 
	global_position = Vector2(1750, 1250)

	if audio.stream:
		audio.stream.loop = true
	audio.play()


func _next_day_started(): 
	global_position = Vector2(1750, 1250)
