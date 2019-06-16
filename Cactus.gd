extends Area2D

const GROUND = Vector2(1400, 700)
onready var main = get_parent()
onready var dino = get_parent().get_node('Dino')

var lifetime = 5
var jumped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_position(GROUND)
	connect('area_entered', dino, 'collision')
	dino.connect('restart', self, 'restart')

func _physics_process(delta):
	if not main.started:
		return

	var velocity = main.speed
	# decrise postion in X to move cactus from right to left
	set_position(position + velocity * delta)

	# decrise the lifetime of cactus
	lifetime -= delta

	# remove cactus if it has not more lifetime
	if lifetime < 0:
		queue_free()
		
	# check if player not jump this cactus and add to score.
	if not jumped:
		if get_position().x < dino.get_position().x:
			jumped = true
			main.score += main.CACTUS_POINT
			main.get_node('Score').text = 'Score: ' + str(main.score)

func restart():
	queue_free()
