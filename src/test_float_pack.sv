/* Testbench pour le package float_pack */

module test_float_pack;

import float_pack::*;

/* Test des fonctions real2float_ieee et float_ieee2real */


function void verif_real2float_ieee(input shortreal sh);
	float_ieee fl = real2float_ieee(sh);
	// Calcul de la valeur du float_ieee selon la formule
	real val_fl = (-2*fl.s + 1) * (1 + (fl.m/2**23)) * 2**(fl.e - 127);
	$display("Vrai shortreal : %f, apres conversion : %f", sh, val_fl);
	if (sh != val_fl)
		$display("ERROR");
endfunction;


function void verif_float_ieee2real(input float_ieee fl);
	shortreal sh = float_ieee2real(fl);
	// Calcul de la valeur du float_ieee selon la valeur
	real val_fl = (-2*fl.s + 1) * (1 + (fl.m/2**23)) * 2**(fl.e - 127);
	$display("Valeur calculee :", val_fl, "valeur convertie :", sh);
	if (sh != val_fl)
		$display("ERROR");
endfunction;


initial
	begin

	/* Une série de tests pour real2float_ieee*/

float_ieee tab_ieee [20:0];
shortreal tab [9:0];

	tab[0] = 1.345945474;
	tab[1] = 6345.6703;
	tab[2] = 34.8765;
	tab[3] = 0;
	tab[4] = -45.2346;
	tab[5] = 0.3093;
	tab[6] = 0.000037;
	tab[7] = -0.300002;
	tab[8] = -34508373.4582;
	tab[9] = 100000;

	for (int i = 0; i < 9; i++) begin
		verif_real2float_ieee(tab[i]);
	end

	/* Une série de tests pour float_ieee2real
	 * On tire aléatoirement des signes, mantisses, exposants, en faisant attention de rester dans les bornes */


	for (int i = 0; i < 21; i++) begin
		tab_ieee[i].m = $random();
		tab_ieee[i].e = $random() % 254;
		tab_ieee[i].s = $random() % 1;
		verif_float_ieee2real(tab_ieee[i]);
	end


end

endmodule
