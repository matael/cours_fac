%
% debit_fonce.m
%
% Copyright (C) 2013 Mathieu Gaborit (matael) <mathieu@matael.org>
%
%
% Distributed under WTFPL terms
%
%            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
%                    Version 2, December 2004
%
% Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
%
% Everyone is permitted to copy and distribute verbatim or modified
% copies of this license document, and changing it is allowed as long
% as the name is changed.
%
%            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
%   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
%
%  0. You just DO WHAT THE FUCK YOU WANT TO.
%

function [y] = debit_fonce(x)
	fact_debit = 100/6;
	a = 2.4*fact_debit/(-9)*100;
	b = 13.5*fact_debit+a*12e-2;
	y = (a*x*10^-2+b);
end

