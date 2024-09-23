extends CharacterBody2D

@export var movement_speed = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func move() -> void:
	if Input.is_action_pressed("ui_left"):
		position.x-=1.5
	if Input.is_action_pressed("ui_right"):
		position.x +=1.5
	if Input.is_action_pressed("ui_up"):
		position.y -=1.5
	if Input.is_action_pressed("ui_down"):
		position.y +=1.5

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move()
