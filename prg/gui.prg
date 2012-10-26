import "mod_draw";

/* ------------------------------------------------------------------------- */
function int draw_bar( int value )

private

	int x0 = 10;
	int x1 = 30;
	
	int y0 = 100;
	int y1 = 110;
	
	int width;
	int height;
	
	int width_total;
	int width_value;
	
	int map_id;

end

begin

	width = x1-x0;
	height = y1-y0;

	map_id = map_new( width, height, SCREEN_D);
	
	drawing_map ( 0, map_id );
	
	width_total = (x1-x0)-2;
	width_value = (width_total * value) / 100;
	
	draw_line ( 1, 0, width - 2, 0 );
	draw_line ( 1, height-1, width - 2, height-1 );
	
	draw_line ( 0, 1, 0, height - 2 );
	draw_line ( width-1, 1, width-1, height - 2 );
	
	if ( value > 0 )
		draw_box ( 1, 1, 1+width_value, height-2 );
	end
	
	return map_id;

end
