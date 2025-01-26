extends CharacterBody2D


const max_speed = 200
var last_direction:=Vector2(1,0)

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity= direction*max_speed
	move_and_slide()
	
	if direction.length()>0:
		last_direction=direction
		play_walk_animation(direction)
	else : 
		play_idle_animation(last_direction)
	
func play_walk_animation(direction): 
	if direction.x>0 and direction.y==0 : 
		$AnimatedSprite2D.play("WalkAnimationRight")
	elif direction.x>0 and direction.y>0 : 
		$AnimatedSprite2D.play("WalkAnimationDownRight")
	elif direction.x>0 and direction.y<0 : 
		$AnimatedSprite2D.play("WalkAnimationUpRight")
	elif direction.x<0 and direction.y==0: 
		$AnimatedSprite2D.play("WalkAnimationLeft")
	elif direction.x<0 and direction.y>0 : 
		$AnimatedSprite2D.play("WalkAnimationDownLeft")
	elif direction.x<0 and direction.y<0 : 
		$AnimatedSprite2D.play("WalkAnimationUpLeft")
	if direction.x==0 and direction.y>0 : 
		$AnimatedSprite2D.play("WalkAnimationDown")
	if direction.x==0 and direction.y<0 : 
		$AnimatedSprite2D.play("WalkAnimationUp")
		
func play_idle_animation(direction): 
	if direction.x>0 and direction.y==0 : 
		$AnimatedSprite2D.play("IdleAnimationRight")
	elif direction.x>0 and direction.y>0 : 
		$AnimatedSprite2D.play("IdleAnimationDownRight")
	elif direction.x>0 and direction.y<0 : 
		$AnimatedSprite2D.play("IdleAnimationUpRight")
	elif direction.x<0 and direction.y==0: 
		$AnimatedSprite2D.play("IdleAnimationLeft")
	elif direction.x<0 and direction.y>0 : 
		$AnimatedSprite2D.play("IdleAnimationDownLeft")
	elif direction.x<0 and direction.y<0 : 
		$AnimatedSprite2D.play("IdleAnimationUpLeft")
	if direction.x==0 and direction.y>0 : 
		$AnimatedSprite2D.play("IdleAnimationDown")
	if direction.x==0 and direction.y<0 : 
		$AnimatedSprite2D.play("IdleAnimationUp")
		
