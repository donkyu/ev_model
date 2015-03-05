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


% Model validation 
% The coefficients should be substituted manually
Q = (0.3680+9.3919*sind(Pitch_sample)+0.9571*Acc_sample)*612.7;
Model_power_com = Velocity_sample.*Q/3.6+18.242*Velocity_sample.^2/12.96+0.0026*Q.^2+101.3393*Velocity_sample/3.6-53.3157;

% When torque is under zero, power consumption goes zero
for count = 1:number
    if Model_power_com(count,1) < 0
        Model_power_com(count,1) = 0;
    end
    if Q(count,1)<0
        Model_power_com(count,1) = 0;
    end
end

% Regen-brake model turns on when torque is under zero and the driver take his
% foot off from the accel
Regen = zeros(number,1);
for count = 298:number
   if Q(count,1)<0
    Regen(count,1) = 460.53*Velocity_sample(count,1)/3.6-355.9198; 
   end
end
Model_power_com = Model_power_com-Regen;

% When velocity is zero, the estimated power goes zero
for count = 1:number
    if Velocity_sample(count,1) ==0;
        Model_power_com(count,1) = 0;
    end
end


% RMS error 
for count = 1:number
    MSE(count,1) = (Battery_power(count,1)-Model_power_com(count,1))^2;
    TOT(count,1) = Battery_power(count,1)*Battery_power(count,1);
end

MSE_1 = sum(MSE);
TOT_1 = sum(TOT);
RMS = sqrt(MSE_1/TOT_1)*100


% Plot model and measured data
subplot(4,1,1)
hold off
plot(Model_power_com,'r');
hold on
plot(Battery_power,'b');
hold on
grid on
ylabel('Power (W)','fontname','Times New Roman','fontsize',15)
xlabel('Time (0.5s)','fontname','Times New Roman','fontsize',15)

% Mapped degree
subplot(4,1,2)
hold off
plot(Pitch_sample);
hold on
grid on
ylabel('degree (o)','fontname','Times New Roman','fontsize',15)
xlabel('Time (0.5s)','fontname','Times New Roman','fontsize',15)
% axis([0 140 -2 2]);

% Acceleration
subplot(4,1,3)
hold off
plot(Acc_sample);
hold on
grid on
ylabel('Acceleration (m/s2)','fontname','Times New Roman','fontsize',15)
xlabel('Time (0.5s)','fontname','Times New Roman','fontsize',15)

% Velocity
subplot(4,1,4)
hold off
plot(Velocity_sample);
hold on
grid on
ylabel('Velocity (m/s)','fontname','Times New Roman','fontsize',15)
xlabel('Time (0.5s)','fontname','Times New Roman','fontsize',15)
