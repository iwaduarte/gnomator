extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StartGameButton.show()
	$Message.show()
	
func update_score(score):
	$Score.text = "Score: " + str(score)
func update_countdown(time_left):
	$TimeLeft.text = str(time_left)
	
func new_game()->void:
	$TimeLeft.text = str(30)
	$Score.text = "Score: 0"
	$Score.show()
	$TimeLeft.show()
	$StartGameButton.hide()
	$Message.hide()
	
func game_over()->void:
	$TimeLeft.hide()
	$StartGameButton.show()
	$Message.show()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
