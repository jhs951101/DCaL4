function x = triangle(tau, T1, T2, fs)
% 
%*************************************************
% Generation of triangular pulse
% tau : pulse width [sec]
% fs : sampling frequency
%       fs must be greater than or equal to 2/T
% [T1, T2] : observation time interval [sec]
% df : frequency resolution [Hz]
%
% example 
% x=rect(2, -5, 5, 10, 0.01)
%**************************************************

ts=1/fs; %sampling period
t=[T1:ts:T2]; %observation time interval

% Signal genaration of triangular pulse
x=zeros(size(t));
midpoint=floor((T2-T1)/2/ts)+1;
L1=midpoint-fix(tau/2/ts);
L2=midpoint+fix(tau/2/ts)-1;
x(L1:midpoint)=(2/tau)*t(L1:midpoint)+1; %2/tau is the slope
x(midpoint+1:L2)=-(2/tau)*t(midpoint+1:L2)+1;