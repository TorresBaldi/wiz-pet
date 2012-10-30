import "mod_draw";
import "mod_dir";
import "mod_key";
import "mod_map";
import "mod_proc";
import "mod_grproc";
import "mod_screen";
import "mod_say";
import "mod_text";
import "mod_file";
import "mod_video";
import "mod_string";
import "mod_debug";

//---------------------------------------------------------------------------------------
GLOBAL
	
	// SETTINGS
	folder_png = "fpg-sources/";
	folder_fpg = "fpg/";



	string png_name, fpg_name, filename, folder_name;
	int fpg, i, option;

END

//---------------------------------------------------------------------------------------
BEGIN

	set_mode(320, 240, 16, mode_window);

	LOOP

		// obtengo los nombres de las carpetas
		folder_name = glob ( folder_png + "*");

		// salgo del bucle al terminar
		if ( folder_name == "" )
			break;
		end

		// salteo el archivo si no es una carpeta
		if ( folder_name == "." or folder_name == ".." or fileinfo.directory == false )
			continue;
		end

		// creo el nuevo fpg vacio
		fpg = fpg_new();

		// agrego 1 a 1 los png
		FOR (i=1; i<= 999; i++)

			if ( file_exists ( folder_png + folder_name + "/" + i + ".png" ) )
				png_name = load_png( folder_png + folder_name + "/" + i + ".png" );
				fpg_add(fpg, i, 0, png_name);
				say("agregado " + i + ".png a fpg " + fpg + "(" + folder_name + ")");
			end

		END

		// guardo el fpg
		fpg_save(fpg, folder_fpg + folder_name + ".fpg");
		say ( "guardado: " + folder_fpg + folder_name + ".fpg" );
		
	END
	
END
