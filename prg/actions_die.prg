/* ------------------------------------------------------------------------- */
function action_die()

private

	int counter;

end

begin

	file = fpg_pet;
	
	graph = 10;
	
	size = 200;
	
	x = 160;
	y = 120;
	
	while ( size > 0 )
	
		size -= 4;
		
		frame;
		
	end
	
	stats.status = STA_DEAD;

end
