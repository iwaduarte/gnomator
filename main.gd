extends Node2D
@export var gift_scene: PackedScene 
var screen_size
const MAX_GIFTS = 10
var gift_count = 0
var GIFT_STATUS = ["evil", "good", "neutral"]
var score = 0
var gift_reference
var time_left


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size
	$CanvasLayer/Score.hide()
	$CanvasLayer/TimeLeft.hide()
	$Gnome.hide()
	$Belt.hide()
	$GnomeNPC.hide()
	$GnomeNPC2.hide()
	$GnomeNPC3.hide()
	
	
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
		score -=1
	gift_count-=1
	$CanvasLayer.update_score(score)
	

func _on_gift_timer_timeout() -> void: 
	if (gift_count >= MAX_GIFTS):
		return
	var selected_evil_gnome = GIFT_STATUS[randi() % GIFT_STATUS.size()]
	var gift = gift_scene.instantiate()
	gift.constructor(selected_evil_gnome)
	var half_screen_size = int(screen_size.x / 2)
	var random_x = (randi() % half_screen_size) + half_screen_size - 85
	var random_y = randi() % screen_size.y
	gift.position = Vector2(random_x, random_y)
	gift.connect("gift_collected", pick_gift)
	gift.connect("gift_expired", gift_expired)
	add_child(gift)
	gift_count+=1
	
func game_over() -> void:
		$CanvasLayer.update_countdown(0)
		$CountDownTimer.stop()  # Stop the timer when it reaches 0
		$GiftTimer.stop()
		$Belt.hide()
		$Gnome.hide()
		$GnomeNPC.hide()
		$GnomeNPC2.hide()
		$GnomeNPC3.hide()
		$CanvasLayer.game_over()
		gift_scene.instantiate().picked_id = null
		get_tree().call_group("gifts", "queue_free")
		
		print("Your score is ", score)
		
func _on_count_down_t_imer_timeout() -> void:
	
	if time_left > 0:
		time_left -= 1  # Decrease the time by 1 second
		$CanvasLayer.update_countdown(time_left)
	if time_left == 0:
		game_over()


func _on_start_game_button_pressed() -> void:
	time_left = 30
	gift_count = 0
	score = 0
	$CanvasLayer.new_game()
	$CountDownTimer.start()
	$GiftTimer.start()
	$Gnome.show()
	$Belt.show()
	$GnomeNPC.show()
	$GnomeNPC2.show()
	$GnomeNPC3.show()
	
