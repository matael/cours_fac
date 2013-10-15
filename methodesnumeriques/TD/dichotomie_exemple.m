clear all;
close all;

x0 = 0;
x1 = 2;

goal = 1;
guess = goal+10; % just to enter the loop

while (abs(goal-guess) >= 0.5e-5)
	xc = (x0+x1)/2;
	disp(num2str(xc));
	if (x0^3+x0-goal)*(xc^3+xc-goal) < 0
		x1 = xc;
	else
		x0 = xc;
	end
	guess = x0^3+x0;
end

disp(['f(',num2str(x0),') = ',num2str(guess)]);

