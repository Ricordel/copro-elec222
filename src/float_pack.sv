package float_pack;

// Tout est paramétrable :
// Taille totale : 
parameter n_float = 32;
// La taille de l'exposant
parameter n_e = 8;
// La taille de la mantisse
parameter n_m = 23;

// Structure representant notre flottant
typedef struct packed {
	logic s;
	logic [n_e-1:0] e;
	logic [n_m-1:0] m;
} float;


// Structure représentant un float normalisé IEEE
typedef struct packed {
	logic s;
	logic [7:0] e;
	logic [23:0] m;
} float_ieee;




// Fonction de conversion d'un shortreal SV vers un float IEEE
function float_ieee real2float_ieee(input shortreal sh);
	return $shortrealtobits(sh);
endfunction

// Fonction de conversion d'un float_ieee vers un shortreal
function shortreal float_ieee2real(input float_ieee fl);
	return $bitstoshortreal(fl);
endfunction


/* Fonction de conversion d'un shortreal vers un type float
 *		- Conversion du shortreal en float_ieee
 *		- conversion du float_ieee en float (modification des tailles)
 */
function float real2float(shortreal sh);
begin
	float max = {0, (n_e-2){1'b1}, 2'b01, n_m{1'b1}; // saturation avec exposant = 2*n_e - 2

	float_ieee fl_ieee = real2float_ieee(sh);

	// !!! decalage !!!
	// Si le nombre ieee est trop grand pour aller dans un float, on sature
	if (fl_ieee.e - 127 > 2**n_e - 2)
		return max;
	else if (fl_ieee.e < 
	

endpackage
