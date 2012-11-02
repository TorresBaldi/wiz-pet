import "mod_map";
import "mod_proc";
import "mod_grproc";
import "mod_key";
import "mod_rand";
import "mod_screen";
import "mod_video";
import "mod_text";
import "mod_time";
import "mod_timers";
import "mod_wm";
import "mod_file";
import "mod_debug";
import "mod_sound";
import "mod_scroll";
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

	SCREEN_MODE = MODE_WINDOW + WAITVSYNC;	// modo de pantalla

END

/* ------------------------------------------------------------------------- */

GLOBAL

	string ver = "1.0";

END

/* ------------------------------------------------------------------------- */

// libraries
include "prg/jkeys.prg";
include "prg/wiz-keyboard.lib";

// declarations
include "prg/globals.prg";

// game code
include "prg/gui.prg";
include "prg/hud.prg";
include "prg/audio.prg";
include "prg/intro.prg";
include "prg/actions.prg";
include "prg/actions_bath.prg";
include "prg/actions_die.prg";
include "prg/actions_food.prg";
include "prg/actions_heal.prg";
include "prg/actions_info.prg";
include "prg/actions_move.prg";
include "prg/actions_play_ball.prg";
include "prg/actions_play_tateti.prg";
include "prg/actions_sweep.prg";
include "prg/caca.prg";
include "prg/game.prg";
include "prg/ticks.prg";
include "prg/pet.prg";
include "prg/menu.prg";
include "prg/credits.prg";
include "prg/graveyard.prg";

// extra
include "prg/debug.prg";


/* ------------------------------------------------------------------------- */


BEGIN

	// inicializo video dependiendo el OS
	switch ( OS_ID )

		case OS_GP2X_WIZ:

			set_mode(320, 240, 16, MODE_FULLSCREEN);
			set_fps(SCREEN_FPS,2);
			
			transition_speed = 75;

		end

		default:

			set_title("WIZPet " + ver);
			scale_resolution = (SCREEN_X * SCREEN_SCALE) * 10000 + (SCREEN_Y * SCREEN_SCALE);
			set_mode(SCREEN_X, SCREEN_Y, SCREEN_D, SCREEN_MODE);
			set_fps(SCREEN_FPS,0);

			transition_speed = 25;
			
		end

	end
	
	rand_seed( time() );

	// inicio el bucle del juego
	game_controller();

END

function load_data()

private
	int i;
	int found;
	int time_delta;
end

begin

	//cargo tiempo anterior
	if ( fexists("time.dat") )
	
		load( "time.dat", data );
		found = true;
		
	else
	
		// inicio el tiempo nuevo
		data.first_time = time();
		data.last_time = time();

	end

	// calculo el tiempo que paso
	time_delta = time() - data.last_time;

	// modifico los stats
	calcular_ticks ( time_delta / tick );
	
	//elimino las IDs de las cacas que pueden haber quedado
	for( i=0; i <= 5; i++ )
		data.dump[0][i][3] = false;
		data.dump[1][i][3] = false;
	end
	
	return found;

end

/* ------------------------------------------------------------------------- */
function do_exit()

begin
	data.last_time = time();
	save( "time.dat", data );
	exit();
end

/* ------------------------------------------------------------------------- */
/*
	Controla que se suelten todas las teclas para liberar key_lock
	Se llama en cada frame
*/
function global_key_lock()
private
	int i;
end
begin

	// global_key_lock check
	IF( global_key_lock )

		global_key_lock = false;

		// si hay alguna tecla presionada, vuelvo a bloquear
		if ( mouse.left )

			global_key_lock = true;

		else
			for ( i=0; i< _JKEY_LAST-2; i++ )
				if ( jkeys_state[i] )

					global_key_lock = true;
					break;

				end
			end
		end

		//say(global_key_lock);

	END
end
