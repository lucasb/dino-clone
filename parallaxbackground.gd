extends ParallaxBackground

var parallax_offset = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node('ParallaxLayer/Ground').set_position(Vector2(0, 706))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not get_parent().started:
		return

	parallax_offset -= delta * -get_parent().speed
	set_scroll_offset(parallax_offset)
