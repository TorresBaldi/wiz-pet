/* ------------------------------------------------------------------------- */
function action_move()

begin

	if ( stats.lugar == 1 )
		stats.lugar = 2;
	else
		stats.lugar = 1;
	end

	function_screen_transition();
	
	put( fpg_bg, stats.lugar, 160, 120 );
	
	screen_transition();

end

function function_screen_transition()

begin

	screen_transition();

end

process screen_transition()

begin

	file = 0;
	
	x = 160;
	y = 120;
	
	graph = screen_get();
	
	loop
	
		alpha -= 8;
		
		if ( alpha <= 0 ) break; end
	
		frame;
		
	end

end
