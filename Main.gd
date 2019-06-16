extends Node

const CACTUS_POINT = 10

var speed = Vector2(-500, 0)
var initial_speed = speed
var initial_bg_offset = Vector2()
var started = false
var score = 0
var record = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node('Dino').connect('restart', self, 'on_restart')
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Stop process if game is not started
	if not started:
		return
	speed.x -= delta/10

func on_restart():
	score = 0
	get_node('Score').text = 'Score: 0'
	speed = initial_speed
	$ParallaxBackground.set_scroll_offset(initial_bg_offset)
