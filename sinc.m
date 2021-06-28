function Pulse = sinc(time, ts, tau)

min_time = min(time);
max_time = max(time);
Pulse = min_time : ts : max_time;
i = 1;

while i <= (max_time - min_time) / ts + 1
	if time(1,i) > tau * -1 && time(1,i) < tau
        x = 100 * time(1,i);
		Pulse(1,i) = sin(pi * x) / (pi * x);
	else
		Pulse(1,i) = 0;
	end

	i = i + 1;
end