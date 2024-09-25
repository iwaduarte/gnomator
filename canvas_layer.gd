extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TimeLeft.text = str(30)
	$Score.text = "Score: 0"
func update_score(score):
	$Score.text = "Score: " + str(score)
func update_countdown(time_left):
	$TimeLeft.text = str(time_left)
	
func start():
	$Score.show()
	$TimeLeft.show()
	$StartGameButton.hide()
	$Message.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
