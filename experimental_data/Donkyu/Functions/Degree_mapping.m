% Determine the start time and end time for regression data 
time_start = 14;
time_fin = 297;

% Calculating location the EV by integrating the velocity by time
size_of_sample = size(Velocity_sample);
for count = 1:time_start-1
    sample_distance(count,1) = 0;
end
for count = time_start:time_fin
   sample_distance(count,1) = sample_distance(count-1,1)+Velocity_sample(count,1)*0.5/3.6;
end
sample_total_distance = sample_distance(time_fin,1);

for count = time_fin+1:size_of_sample
    sample_distance(count,1) = sample_total_distance;
end

% Matching the raw degree data to the data log
size_of_Ref = size(Ref_degree);
for count = 1:size_of_sample(1,1)
   for count_2 = size_of_Ref(1,1):-1:1
       if sample_distance(count,1) >= Ref_distance(count_2,1)
          Pitch_sample(count,1) = Ref_degree(count_2,1);
          break;
       end
   end
end

subplot(2,1,1)
hold off
plot(Pitch_sample);
hold on

subplot(2,1,2)
hold on
plot(Ref_degree)
hold off 


% Trimming the data
% y_count starts at y_count = 1 at the beginning
% Collect all data which the EV mass and road are same
Power = 0;
Vel = 0;
for count = time_start:time_fin
    Power = Power+Battery_power(count,1);
    Vel = Vel+Velocity_sample(count,1);
end

Power = Power/(time_fin-time_start+1);
Vel = Vel/(time_fin-time_start+1);

for count = time_start:time_fin
    y_kg_power(y_count,1) = Battery_power(count,1);
    y_kg_vel(y_count,1) = Velocity_sample(count,1);
    y_kg_acc(y_count,1) = Acc_sample(count,1);
    y_kg_theta(y_count,1) = Pitch_sample(count,1);
    y_count = y_count+1;
end
