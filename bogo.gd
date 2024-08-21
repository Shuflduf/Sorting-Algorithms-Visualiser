extends Sorter


func sort():
	while !owner.sorted():
		await get_tree().process_frame
		owner.shuffle_bars()
