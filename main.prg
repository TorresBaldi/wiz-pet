import "mod_map";
import "mod_proc";
import "mod_grproc";
import "mod_key";
import "mod_rand";
import "mod_screen";
import "mod_video";
import "mod_text";
import "mod_time";
import "mod_wm";
import "mod_file";
import "mod_debug";
import "mod_say";

/* ------------------------------------------------------------------------- */

CONST

	// parametros de video
	SCREEN_X = 320;	// resolucion x
	SCREEN_Y = 240;	// resolucion y
	SCREEN_D = 16;	// profundidad de color

	SCREEN_SCALE = 2;	// escalado de pantalla (2x, 3x)
	
	SCREEN_FPS	= 60;	// frames
	SCREEN_SKIP	= 0;	// frameskip
	
	SCREEN_MODE = MODE_WINDOW;	// modo de pantalla

END

/* ------------------------------------------------------------------------- */

include "prg/globals.prg";

/* ------------------------------------------------------------------------- */


BEGIN

	set_title("WizPet");
	scale_resolution = (SCREEN_X * SCREEN_SCALE) * 10000 + (SCREEN_Y * SCREEN_SCALE);
	set_mode(SCREEN_X, SCREEN_Y, SCREEN_D, SCREEN_MODE);
	set_fps(SCREEN_FPS,2);
	
	write_var(0,0,0,0,fps);
	
	calcular_tiempo();

	LOOP

		IF ( EXIT_STATUS OR KEY(_ESC) )
		
			guardar_tiempo();
		
			exit();
		END

		frame;

	END


END

function string segundos_a_string( int segundos )

private

	hms t;

end

begin

	t.s = segundos;

	while ( t.s > 60 )
	
		t.s -= 60;
		t.m += 1;
	
	end
	
	while ( t.m > 60 )
	
		t.m -= 60;
		t.h += 1;
	
	end
	
	return "" + t.h + "h " + t.m + "m " + t.s + "s";

end

process guardar_tiempo()

BEGIN

	// guardo el tiempo de salida
	time.last = time();
	
	// aumento el tiempo que paso dentro del juego
	time.delta += time.last - time.current;
	
	// guardo el archivo
	save( "time.dat", time );

END

process calcular_tiempo()

BEGIN

	// cargo el archivo
	load( "time.dat", time );

	// calculo el tiempo que paso desde la ultima partida
	time.current = time();
	
	time.delta += time.current - time.last;
	
	say( segundos_a_string( time.delta ) );

END
