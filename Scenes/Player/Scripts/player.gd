extends CharacterBody2D


const max_speed = 200
var last_direction:=Vector2(1,0)
var sword:=bool(false)

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
	if self.get_meta("sword") : 
		play_sword_walk_animation(direction)
	else : 
		play_basic_walk_animation(direction)
		
func play_idle_animation(direction):
	if self.get_meta("sword") : 
		play_sword_idle_animation(direction)
	else : 
		play_basic_idle_animation(direction)
		
func play_basic_walk_animation(direction): 
	if direction.x>0 and direction.y==0 : 
		$AnimatedSprite2D.play("BasicWalkAnimationRight")
	elif direction.x>0 and direction.y>0 : 
		$AnimatedSprite2D.play("BasicWalkAnimationDownRight")
	elif direction.x>0 and direction.y<0 : 
		$AnimatedSprite2D.play("BasicWalkAnimationUpRight")
	elif direction.x<0 and direction.y==0: 
		$AnimatedSprite2D.play("BasicWalkAnimationLeft")
	elif direction.x<0 and direction.y>0 : 
		$AnimatedSprite2D.play("BasicWalkAnimationDownLeft")
	elif direction.x<0 and direction.y<0 : 
		$AnimatedSprite2D.play("BasicWalkAnimationUpLeft")
	if direction.x==0 and direction.y>0 : 
		$AnimatedSprite2D.play("BasicWalkAnimationDown")
	if direction.x==0 and direction.y<0 : 
		$AnimatedSprite2D.play("BasicWalkAnimationUp")
		
func play_basic_idle_animation(direction): 
	if direction.x>0 and direction.y==0 : 
		$AnimatedSprite2D.play("BasicIdleAnimationRight")
	elif direction.x>0 and direction.y>0 : 
		$AnimatedSprite2D.play("BasicIdleAnimationDownRight")
	elif direction.x>0 and direction.y<0 : 
		$AnimatedSprite2D.play("BasicIdleAnimationUpRight")
	elif direction.x<0 and direction.y==0: 
		$AnimatedSprite2D.play("BasicIdleAnimationLeft")
	elif direction.x<0 and direction.y>0 : 
		$AnimatedSprite2D.play("BasicIdleAnimationDownLeft")
	elif direction.x<0 and direction.y<0 : 
		$AnimatedSprite2D.play("BasicIdleAnimationUpLeft")
	if direction.x==0 and direction.y>0 : 
		$AnimatedSprite2D.play("BasicIdleAnimationDown")
	if direction.x==0 and direction.y<0 : 
		$AnimatedSprite2D.play("BasicIdleAnimationUp")
		
func play_sword_walk_animation(direction): 
	if direction.x>0 and direction.y==0 : 
		$AnimatedSprite2D.play("SwordWalkAnimationRight")
	elif direction.x>0 and direction.y>0 : 
		$AnimatedSprite2D.play("SwordWalkAnimationDownRight")
	elif direction.x>0 and direction.y<0 : 
		$AnimatedSprite2D.play("SwordWalkAnimationUpRight")
	elif direction.x<0 and direction.y==0: 
		$AnimatedSprite2D.play("SwordWalkAnimationLeft")
	elif direction.x<0 and direction.y>0 : 
		$AnimatedSprite2D.play("SwordWalkAnimationDownLeft")
	elif direction.x<0 and direction.y<0 : 
		$AnimatedSprite2D.play("SwordWalkAnimationUpLeft")
	if direction.x==0 and direction.y>0 : 
		$AnimatedSprite2D.play("SwordWalkAnimationDown")
	if direction.x==0 and direction.y<0 : 
		$AnimatedSprite2D.play("SwordWalkAnimationUp")
		
func play_sword_idle_animation(direction): 
	if direction.x>0 and direction.y==0 : 
		$AnimatedSprite2D.play("SwordIdleAnimationRight")
	elif direction.x>0 and direction.y>0 : 
		$AnimatedSprite2D.play("SwordIdleAnimationDownRight")
	elif direction.x>0 and direction.y<0 : 
		$AnimatedSprite2D.play("SwordIdleAnimationUpRight")
	elif direction.x<0 and direction.y==0: 
		$AnimatedSprite2D.play("SwordIdleAnimationLeft")
	elif direction.x<0 and direction.y>0 : 
		$AnimatedSprite2D.play("SwordIdleAnimationDownLeft")
	elif direction.x<0 and direction.y<0 : 
		$AnimatedSprite2D.play("SwordIdleAnimationUpLeft")
	if direction.x==0 and direction.y>0 : 
		$AnimatedSprite2D.play("SwordIdleAnimationDown")
	if direction.x==0 and direction.y<0 : 
		$AnimatedSprite2D.play("SwordIdleAnimationUp")
		
