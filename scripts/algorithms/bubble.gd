extends Sorter

func sort():
	while !owner.is_sorted():
		for i in %Bars.get_child_count() - 1:
			var bar = %Bars.get_child(i)
			var next_bar = %Bars.get_child(i + 1)
			if bar.custom_minimum_size.y > next_bar.custom_minimum_size.y:
				await owner.swap_bars(i, i + 1)
