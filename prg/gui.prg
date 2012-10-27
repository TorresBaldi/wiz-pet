import "mod_draw";
/* ------------------------------------------------------------------------- */
process botones() 

private

	int key_lock;

end

begin

	loop
	
		if ( key_lock == false )
		
			if ( key(_a) )
			
				say("Comida!");
				key_lock = true;
				
				stats.hambre += 200;
				
			elseif ( key(_s) )
			
				say("Medicina!");
				key_lock = true;
				
				stats.salud += 200;
			
			elseif ( key(_d) )
			
				say("Juegos!");
				key_lock = true;
				
				stats.diversion += 200;
			
			elseif ( key(_f) )
			
				say("Ducha!");
				key_lock = true;
				
				stats.higiene += 200;
			
			elseif ( key(_g) )
			
				say("Dormir!");
				key_lock = true;
				
				stats.energia += 200;
			
			end
		
		else
		
			if ( !key (_a) and !key(_s) and !key(_d) and !key(_f) and !key(_g) )
			
				key_lock = false;
				
			end
		
		end
	
		frame;
		
	end

end

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
