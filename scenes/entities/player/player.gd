extends CharacterBody2D

enum State {
	IDLE,
	RUN,
	ATTACK,
	DEAD
}

const FLIP_STATES = [State.IDLE, State.RUN, State.ATTACK]

@export_category("State")
@export var speed: int = 400

var state: State = State.IDLE
var move_direction: Vector2 = Vector2.ZERO

@onready var animation_tree: AnimationTree = %AnimationTree
@onready var animation_playback: AnimationNodeStateMachinePlayback = %AnimationTree["parameters/playback"]
@onready var player_sprite: Sprite2D = %PlayerSprite


func _ready() -> void:
	animation_tree.active = true

func _physics_process(_delta: float) -> void:
	movement_loop()
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		attack()


func attack() -> void:
	if state == State.ATTACK:
		return
	state = State.ATTACK
	update_animation()





func movement_loop() -> void:
	if state == State.ATTACK:
		return
	
	move_direction = Input.get_vector("left", "right", "up", "down")
	var motion: Vector2 = move_direction.normalized() * speed
	set_velocity(motion)
	move_and_slide()
	
	if state in FLIP_STATES:
		if move_direction.x != 0:
			player_sprite.flip_h = move_direction.x < 0
	
	var old_state = state
	if motion != Vector2.ZERO and state == State.IDLE:
		state = State.RUN
	elif motion == Vector2.ZERO and state == State.RUN:
		state = State.IDLE
	
	if state != old_state:
		update_animation()


func update_animation() -> void:
	match state:
		State.IDLE:
			animation_playback.travel("idle")
		State.RUN:
			animation_playback.travel("run")
		State.ATTACK:
			animation_playback.travel("attack1")


func _on_attack_finished() -> void:
	state = State.IDLE
	update_animation()


func _on_hit_box_area_entered(_area: Area2D) -> void:
	pass
