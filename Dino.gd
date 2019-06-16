extends Area2D

const GROUND = Vector2(120, 655)
const GRAVITY = 4000
const JUMP = -1200
const LOW_JUMP_GRAVITY_MODIFIER = 2.5
const CACTUS = [
	preload('res://CactusOneSmall.tscn'),
	preload('res://CactusTwoSmall.tscn'),
	preload('res://CactusThreeSmall.tscn'),
	preload('res://CactusOneBig.tscn'),
	preload('res://CactusTwoBig.tscn'),
	preload('res://CactusThreeBig.tscn')
]

signal restart

var interval = 3
var loop_time = 0.0 
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_position(GROUND)
	$AnimationPlayer.play('stopped')
	randomize()

func _physics_process(delta):
	# Stop process if game is not started
	if not get_parent().started:
		return
	# incrise time with delta time interval
	loop_time += delta
	
	# if loop_interval is grant or equal than 1, ir 4 sec
	if loop_time >= interval:
		# restart loop_time
		loop_time = 0.0
		# add a random cactus on node screen
		var random_cactus_idx = rand_range(0, CACTUS.size())
		get_parent().add_child(CACTUS[random_cactus_idx].instance())
		# random interval between cactus
		interval = rand_range(1, 4)
	
	# jump
	if Input.is_action_pressed('jump'):
		# as high is dino as aceleration incrise
		velocity.y += GRAVITY * delta
	else:
		# as high is dino as aceleration incrise, 
		# plus modifier for a fast fall in a lower jump 
		velocity.y += GRAVITY * delta * LOW_JUMP_GRAVITY_MODIFIER
	
	if Input.is_action_just_pressed('jump') and position == GROUND:
		velocity.y = JUMP
	
	# fall based on the velocity in Y
	position += velocity * delta
	

	# avoid dino drop down beyond the ground
	if get_position().y > GROUND.y:
		set_position(GROUND)

func collision(area):
	$AnimationPlayer.play('dead')
	var main = get_parent()
	# stop game if dion die
	main.started = false
	# set new record if point is grant than record
	if main.score > main.record:
		main.record = main.score
	# eliminate dino referance from screen
	# queue_free()

func _input(event):
	if event is InputEventKey:
		var main = get_parent()
		if not main.started and not event.is_echo():
			emit_signal('restart')
			main.started = false
			main.get_node('Record').text = 'Record: ' + str(main.record)
		main.started = true
		$AnimationPlayer.play('run')