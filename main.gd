extends Node2D
@export var gift_scene: PackedScene 
var screen_size
const MAX_GIFTS = 10
var gift_count = 0
var GIFT_STATUS = ["evil", "good", "neutral"]
var score =0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func gift_expired():
	gift_count-=1
	
func pick_gift(body):
	if body.type == "good":
		score +=1
	elif body.type == "neutral":
		print("Neutral") 
	elif body.type == "evil":
		score -=5

	gift_count-=1
	score +=1

func _on_gift_timer_timeout() -> void: 
	var selected_evil_gnome = GIFT_STATUS[randi() % GIFT_STATUS.size()]
	var gift = gift_scene.instantiate()
	gift.constructor(selected_evil_gnome)
	var half_screen_size = int(screen_size.x / 2)
	var random_x = (randi() % half_screen_size) + half_screen_size - 85
	var random_y = randi() % screen_size.y
	gift.position = Vector2(random_x, random_y)
	gift.connect("gift_collected", pick_gift)
	gift.connect("gift_expired", gift_expired)
	
	if (gift_count < MAX_GIFTS):
		add_child(gift)
		gift_count+=1

func _on_count_down_t_imer_timeout() -> void:
	$GiftTimer.stop()
	$Belt.hide()
	$Gnome.hide()
	print("Your score is", score)
