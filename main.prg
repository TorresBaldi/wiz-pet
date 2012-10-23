import "mod_map";
import "mod_proc";
import "mod_grproc";
import "mod_key";
import "mod_rand";
import "mod_screen";
import "mod_video";
import "mod_time";
import "mod_wm";
import "mod_debug";
import "mod_mouse";

/* ------------------------------------------------------------------------- */


BEGIN

	LOOP

		IF ( EXIT_STATUS OR KEY(_ESC) )
			exit();
		END

		frame;

	END


END
