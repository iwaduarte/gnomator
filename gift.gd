extends Area2D

signal gift_collected
signal gift_expired

var PlayerPicked
var picked = false
var random_pos = 0
var type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if picked:
		position = PlayerPicked.global_position + Vector2(random_pos, 0)
		
func constructor(init_type: String)->void:
	type = init_type

func _on_body_entered(body: Node2D) -> void:
	PlayerPicked = body
	picked = true
	random_pos = randi_range(50, 100)
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("belt"):
		queue_free()
		gift_collected.emit(self)


func _on_timer_timeout() -> void:
	print("Expired")
	gift_expired.emit()
	queue_free()
