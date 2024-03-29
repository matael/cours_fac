function x = dichotomie(f, goal, I)
	% Approximate x in f(x) = goal;
	%
	% f -- handle for function to approximate
	% goal -- value to find
	% I -- [x0, x1], interval containing value


	% extaction des bornes
	x0 = I(1);
	x1 = I(2);

	% on prend une valeur assez loin de l'objectif
	guess = goal+10;

	while (abs(goal-guess) >= 0.5e-5)
		xc = (x0+x1)/2;
		if (f(x0)-goal)*(f(xc)-goal) < 0
			x1 = xc;
		else
			x0 = xc;
		end
		guess = f(x0);
	end

	x = x0;
end
