function Pulse = stepFunction(time, ts)

min_time = min(time);
max_time = max(time);
Pulse = min_time : ts : max_time;
i = 1;

while i <= (max_time - min_time) / ts + 1
	if time(1,i) >= 0
		Pulse(1,i) = 1;
	else
		Pulse(1,i) = 0;
	end

	i = i + 1;
end