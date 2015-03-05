% Size of raw data
buffer = size(Current);
num = buffer(1,1);

% Remove current error
for count = 1:num
   if Current(count,1)>500
      Current(count,1) = Current(count-1,1);
   end
end

% Data_reduction of raw data
Pitch_sample = data_reduction(Pitch, Timestamp_converted);
Velocity_sample = data_reduction(Velocity,Timestamp_converted);
Current_sample = data_reduction(Current, Timestamp_converted);
Voltage_sample = data_reduction(Voltage, Timestamp_converted);
CAN_Velocity_sample = data_reduction(CAN_Velocity, Timestamp_converted);

% Size of sampled data
buffer = size(Velocity_sample);
number = buffer(1,1);

% Calculating acc with Velocity_sample
Acc_sample = ones(1,1);
for count = 1:number
    if (count~=1 && count ~= number)
        Acc_sample(count,1) = (Velocity_sample(count+1,1)-Velocity_sample(count-1,1))/1/3.6 ;
    else
        Acc_sample(count,1) = Velocity_sample(count,1)/0.5/3.6;
    end
end

% Remove acc error
for count = 1:number
   if (Acc_sample(count,1)>3 || Acc_sample(count,1)<-3)
      Acc_sample(count,1) = Acc_sample(count-1,1); 
   end
end

% IMU data compensation
theta = ones(1,1);
for count = 1:number
    theta(count,1) = atand(tand((Pitch_sample(count,1)+210)/1000*180/3.141592)-Acc_sample(count,1)/9.80665);
end

% Calculating the battery power by multiplying the battery current and pack
% voltage
Battery_power = Voltage_sample.*Current_sample;

% Plot model and measured data
subplot(4,1,1)
hold off
plot(Battery_power,'b');
hold on
grid on
ylabel('Power (W)','fontname','Times New Roman','fontsize',15)
xlabel('Time (0.5s)','fontname','Times New Roman','fontsize',15)

% Compensated degree
subplot(4,1,2)
hold off
plot(theta);
hold on
grid on
ylabel('degree (o)','fontname','Times New Roman','fontsize',15)
xlabel('Time (0.5s)','fontname','Times New Roman','fontsize',15)

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



