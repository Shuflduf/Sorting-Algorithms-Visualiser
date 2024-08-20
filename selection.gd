extends Sorter


func sort():
	var checked = 0
	while !owner.sorted():

		var smallest: Panel

		for i in %Bars.get_child_count() - checked:
			var bar = %Bars.get_child(i + checked)
			if smallest == null or bar.custom_minimum_size.y < smallest.custom_minimum_size.y:
				smallest = bar

		await owner.swap_bars(checked, smallest.get_index(), true if owner.speed <= 0.01 else false)

		checked += 1
			#var next_bar = %Bars.get_child(i + 1)
			#if bar.custom_minimum_size.y > next_bar.custom_minimum_size.y:
				#await owner.swap_bars(i, i + 1, true if owner.speed <= 0.01 else false)
