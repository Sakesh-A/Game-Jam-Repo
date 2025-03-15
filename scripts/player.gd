extends CharacterBody2D

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * 400
	move_and_slide()

	if velocity.length() > 0.0:
		$AnimatedSprite2D.play("walk")
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = false
		elif direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		
	else:
		$AnimatedSprite2D.play("idle")
