extends CharacterBody2D

class_name Player

@export var worldState: Resource
@onready var swordHitDown= $SwordHitDown
@onready var swordHitUp= $SwordHitup
@onready var swordHitRight= $SwordHitRight
@onready var animationPlayer=$AnimatedSprite2D
@onready var tail= $Hook/Tail
@onready var sfx_sword=$AudioStreamPlayer2D

const max_speed = 150
var last_direction:=Vector2(1,0)
var sword:=bool(false)
var crossbow:= bool(false)
var staff:= bool(false)
var hook:= bool(false)
var can_move:=bool(true)
var is_attacking:=bool(false)
var last_diagonal_direction: Vector2 = Vector2.ZERO

func desactivate(objet):
	objet.monitoring=false
	objet.get_node("CollisionShape2D").disabled=true

func activate(objet):
	objet.monitoring=true
	objet.get_node("CollisionShape2D").disabled=false

func _ready(): 
	desactivate(swordHitDown)
	desactivate(swordHitUp)
	desactivate(swordHitRight)
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	CaughtTransition.on_caught_transition_started.connect(_on_transition_started)
	CaughtTransition.on_caught_transition_finished.connect(_on_transition_finished)
	if worldState:
		if worldState.current_weapon=="sword":
			sword=true
			crossbow=false
			hook=false
			staff=false
		elif worldState.current_weapon=="hook":
			sword=false
			crossbow=false
			hook=true
			staff=false


func _on_transition_started():
	can_move = false  

func _on_transition_finished():
	can_move = true   

func _input(event):
	if event.is_action_pressed("ui_accept"):
		play_attack_animation(last_direction)
	if event.is_action_pressed("Change_to_sword"):
		if worldState.sword_unlocked:
			sword=true
			crossbow=false
			hook=false
			staff=false
			worldState.current_weapon="sword"
	if event.is_action_pressed("Change_to_hook"):
		if worldState.hook_unlocked:
			sword=false
			crossbow=false
			hook=true
			staff=false
			worldState.current_weapon="hook"


func _physics_process(delta: float) -> void:
	if not can_move:  
		velocity = Vector2.ZERO
		play_idle_animation(last_direction)
		return
	if is_attacking:
		velocity = Vector2.ZERO
		return
	if is_attacking==false:
		var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
		velocity = direction * max_speed
		move_and_slide()
	
		if direction.length() > 0:
			last_direction = direction
			play_walk_animation(direction)
		else:
			play_idle_animation(last_direction)

func play_walk_animation(direction):
	if sword : 
		play_sword_walk_animation(direction)
	elif hook:
		play_hook_walk_animation(direction)
	else : 
		play_basic_walk_animation(direction)
		
func play_idle_animation(direction):
	if sword : 
		play_sword_idle_animation(direction)
	elif hook:
		play_hook_idle_animation(direction)
	else : 
		play_basic_idle_animation(direction)

func play_attack_animation(direction):
	if sword : 
		is_attacking=true
		sfx_sword.play()
		play_sword_attack_animation(direction)
	elif hook:
		tail.start_hook(direction)
	else : 
		pass



func play_basic_walk_animation(direction): 
	if direction.x>0 and direction.y==0 : 
		animationPlayer.play("BasicWalkAnimationRight")
	elif direction.x>0 and direction.y>0 : 
		animationPlayer.play("BasicWalkAnimationDownRight")
	elif direction.x>0 and direction.y<0 : 
		animationPlayer.play("BasicWalkAnimationUpRight")
	elif direction.x<0 and direction.y==0: 
		animationPlayer.play("BasicWalkAnimationLeft")
	elif direction.x<0 and direction.y>0 : 
		animationPlayer.play("BasicWalkAnimationDownLeft")
	elif direction.x<0 and direction.y<0 : 
		animationPlayer.play("BasicWalkAnimationUpLeft")
	if direction.x==0 and direction.y>0 : 
		animationPlayer.play("BasicWalkAnimationDown")
	if direction.x==0 and direction.y<0 : 
		animationPlayer.play("BasicWalkAnimationUp")
		
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
		animationPlayer.play("SwordWalkAnimationRight")
	elif direction.x>0 and direction.y>0 : 
		animationPlayer.play("SwordWalkAnimationDownRight")
	elif direction.x>0 and direction.y<0 : 
		animationPlayer.play("SwordWalkAnimationUpRight")
	elif direction.x<0 and direction.y==0: 
		animationPlayer.play("SwordWalkAnimationLeft")
	elif direction.x<0 and direction.y>0 : 
		animationPlayer.play("SwordWalkAnimationDownLeft")
	elif direction.x<0 and direction.y<0 : 
		animationPlayer.play("SwordWalkAnimationUpLeft")
	if direction.x==0 and direction.y>0 : 
		animationPlayer.play("SwordWalkAnimationDown")
	if direction.x==0 and direction.y<0 : 
		animationPlayer.play("SwordWalkAnimationUp")
		
func play_sword_idle_animation(direction): 
	if direction.x>0 and direction.y==0 : 
		animationPlayer.play("SwordIdleAnimationRight")
	elif direction.x>0 and direction.y>0 : 
		animationPlayer.play("SwordIdleAnimationDownRight")
	elif direction.x>0 and direction.y<0 : 
		animationPlayer.play("SwordIdleAnimationUpRight")
	elif direction.x<0 and direction.y==0: 
		animationPlayer.play("SwordIdleAnimationLeft")
	elif direction.x<0 and direction.y>0 : 
		animationPlayer.play("SwordIdleAnimationDownLeft")
	elif direction.x<0 and direction.y<0 : 
		animationPlayer.play("SwordIdleAnimationUpLeft")
	if direction.x==0 and direction.y>0 : 
		animationPlayer.play("SwordIdleAnimationDown")
	if direction.x==0 and direction.y<0 : 
		animationPlayer.play("SwordIdleAnimationUp")
		
func play_sword_attack_animation(direction): 
	if direction.x==0 and direction.y>0 : 
		activate(swordHitDown)
		animationPlayer.play("SwordAttackAnimationDown")
		var timer = get_tree().create_timer(0.5)
		await timer.timeout
		is_attacking=false
		desactivate(swordHitDown)
		animationPlayer.play("SwordIdleAnimationDown")
	elif direction.x==0 and direction.y<0 : 
		activate(swordHitUp)
		animationPlayer.play("SwordAttackAnimationUp")
		var timer = get_tree().create_timer(0.5)
		await timer.timeout
		is_attacking=false
		desactivate(swordHitUp)
		animationPlayer.play("SwordIdleAnimationUp")
	elif direction.x>0 and direction.y==0 : 
		activate(swordHitRight)
		animationPlayer.play("SwordAttackAnimationRight")
		var timer = get_tree().create_timer(0.5)
		await timer.timeout
		is_attacking=false
		desactivate(swordHitRight)
		animationPlayer.play("SwordIdleAnimationRight")
	else: 
		is_attacking=false

func play_hook_walk_animation(direction): 
	if direction.x>0 and direction.y==0 : 
		animationPlayer.play("HookWalkAnimationRight")
	elif direction.x>0 and direction.y>0 : 
		animationPlayer.play("HookWalkAnimationDownRight")
	elif direction.x>0 and direction.y<0 : 
		animationPlayer.play("HookWalkAnimationUpRight")
	elif direction.x<0 and direction.y==0: 
		animationPlayer.play("HookWalkAnimationLeft")
	elif direction.x<0 and direction.y>0 : 
		animationPlayer.play("HookWalkAnimationDownLeft")
	elif direction.x<0 and direction.y<0 : 
		animationPlayer.play("HookWalkAnimationUpLeft")
	if direction.x==0 and direction.y>0 : 
		animationPlayer.play("HookWalkAnimationDown")
	if direction.x==0 and direction.y<0 : 
		animationPlayer.play("HookWalkAnimationUp")
		
func play_hook_idle_animation(direction): 
	if direction.x>0 and direction.y==0 : 
		animationPlayer.play("HookIdleAnimationRight")
	elif direction.x>0 and direction.y>0 : 
		animationPlayer.play("HookIdleAnimationDownRight")
	elif direction.x>0 and direction.y<0 : 
		animationPlayer.play("HookIdleAnimationUpRight")
	elif direction.x<0 and direction.y==0: 
		animationPlayer.play("HookIdleAnimationLeft")
	elif direction.x<0 and direction.y>0 : 
		animationPlayer.play("HookIdleAnimationDownLeft")
	elif direction.x<0 and direction.y<0 : 
		animationPlayer.play("HookIdleAnimationUpLeft")
	if direction.x==0 and direction.y>0 : 
		animationPlayer.play("HookIdleAnimationDown")
	if direction.x==0 and direction.y<0 : 
		animationPlayer.play("HookIdleAnimationUp")

func _on_spawn(position:Vector2,direction: String): 
	global_position=position
	#play_idle_animation(direction)
