extends Control

@export var count = 10
@export_range(0, 2, 0.01) var speed = 0.5
@export var bar_scene: PackedScene
@export var sorter: Sorter

var max_size: int

func get_max_size() -> int:
	await get_tree().process_frame
	var m = %Bar.size.y
	%Bar.queue_free()
	return m

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_size = await get_max_size()
	for i in count:
		var height = float(i + 1) / float(count)
		var new_bar: Panel = bar_scene.instantiate()
		%Bars.add_child(new_bar)
		new_bar.custom_minimum_size.y = height * max_size

	await get_tree().process_frame
	shuffle_bars()
	sorter.sort()

func swap_bars(first: int, second: int, fast = false):


	var first_bar = %Bars.get_child(first)
	var second_bar = %Bars.get_child(second)

	if fast:
		await get_tree().process_frame
	else:
		first_bar.modulate = Color.RED
		second_bar.modulate = Color.RED
		var first_pos = first_bar.position.x
		var second_pos = second_bar.position.x
		print(first_pos, ", ", second_pos)

		var tween = get_tree().create_tween()
		tween.parallel().tween_property(first_bar, "position:x", second_pos, speed)
		tween.parallel().tween_property(second_bar, "position:x", first_pos, speed)
		await tween.finished
		first_bar.modulate = Color.WHITE
		second_bar.modulate = Color.WHITE
	%Bars.move_child(first_bar, second)
	%Bars.move_child(second_bar, first)

	return

func shuffle_bars():
	randomize()
	for i in count * 100:
		%Bars.move_child(%Bars.get_child(randi_range(0, count - 1)), randi_range(0, count - 1))


func sorted() -> bool:
	var smallest = 0
	for i in %Bars.get_children():
		if smallest > i.custom_minimum_size.y:
			return false
		else:
			smallest = i.custom_minimum_size.y
	return true
