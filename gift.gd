extends Area2D

signal gift_collected
signal gift_expired

static var PlayerPicked
static var picked_id 
var has_picked = false
var random_pos = 0
var type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if has_picked:
		position = PlayerPicked.global_position + Vector2(random_pos, 0)
		
func constructor(init_type: String)->void:
	type = init_type

func _on_body_entered(body: CharacterBody2D) -> void:
	if picked_id:
		return
	PlayerPicked = body
	has_picked = true
	picked_id = get_instance_id()
	print(picked_id)
	random_pos = randi_range(50, 100)
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("belt"):
		if get_instance_id() == picked_id:
			picked_id = null
		queue_free()
		gift_collected.emit(self)


# increment difficulty
func _on_timer_timeout() -> void:
	if picked_id == get_instance_id():
		picked_id = null
	gift_expired.emit()
	queue_free()
