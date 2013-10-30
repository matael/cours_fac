function [x] = newton_raphson(f, x0)

	h = 0.5e-6;
	x = x0;
	diff = @(f,x) (f(x+h)-f(x))/h;
	goal = 0;
	i = 0;
	% newton-raphson algo. should converge
	% in 10 iterations or less
	while ((abs(goal - f(x)) >= 0.5e-5) && i < 10)
		x = x - f(x)/diff(f,x);
		i = i+1;
	end
end
