%% Initialization

clear;

%Load Data from File.
data = xlsread('data2.xls');

time = data(:,1);
time = time(2:end);

velocity = data(:,2);
velocity = velocity(2:end);

acceleration = data(:,5);
acceleration = acceleration(2:end);

slope = data(:,6);
slope = slope(2:end);

measured = data(:,7);
measured = measured(2:end);

estimated = data(:,11);
estimated = estimated(2:end);

z_measured_initial = measured;
z_estimated_initial = estimated;
z_velocity_initial = velocity;
z_acceleration_initial = acceleration;
z_slope_initial = slope;

%filter input
velocity = sgolayfilt(velocity,1,7);
acceleration = sgolayfilt(acceleration,1,7);
slope = sgolayfilt(slope,1,7);

y_velocity_filtered = velocity;
y_acceleration_filtered = acceleration;
y_slope_filtered = slope;

%% Recalculation of estimated power using default coefficients
alpha = 0.4493;
beta = 15.1;
gamma = 1.4774;
mass = 590;

y_estimated_afterfilter = zeros(length(estimated),1);

for i = 1:length(y_estimated_afterfilter)
    y_estimated_afterfilter(i) = (alpha+beta*sin(slope(i)*(pi/180))+gamma*acceleration(i))*mass*velocity(i);
end

y_estimated_afterfilter = sgolayfilt(y_estimated_afterfilter,1,7);

for i = 1:length(y_estimated_afterfilter)
    if y_estimated_afterfilter(i) < 0
        y_estimated_afterfilter(i) = 0;
    end
end

%% Recalculation of estimated power
% alpha = 0.5193;
% beta = 15.1;
% gamma = 1.4774;
alpha = 0.5533;
beta = 15.1;
gamma = 1.4774;
mass = 590; %kg

estimated_recalc = zeros(length(estimated),1);

for i = 1:length(estimated_recalc)
    estimated_recalc(i) = (alpha+beta*sin(slope(i)*(pi/180))+gamma*acceleration(i))*mass*velocity(i);
end

estimated_recalc = sgolayfilt(estimated_recalc,1,7);
estimated_recalc = sgolayfilt(estimated_recalc,1,7);
measured = sgolayfilt(measured,1,7);

for i = 1:length(estimated_recalc)
    if(measured(i) < 0)
        measured(i) = 0;
    end
    
    if(estimated_recalc(i) < 0)
        estimated_recalc(i) = 0;
    end
end

x_estimated_recalc_filtered = estimated_recalc;
x_measured_filtered = measured;

error = abs(sum(measured)-sum(estimated_recalc))/sum(measured)

%calculate differences between estimate and measured.
differences = zeros(length(measured),1);
for i = 1:length(measured)
    differences(i) = abs(measured(i) - estimated_recalc(i));
end

%% Plots
figure(1);
clf;
hold on;
t = 0.1:0.1:150;
plot(t,z_measured_initial/1000);
plot(t,z_estimated_initial/1000,'r');
legend('Measured Power','Estimated Power');
ylabel('Battery Power (kW)');
xlabel('Time (s)');
r_initial_error = abs(sum(z_measured_initial)-sum(z_estimated_initial))/sum(z_measured_initial);
for i=1:length(z_measured_initial)
   if(z_measured_initial(i) == 0)
       z_measured_initial(i) = 0.001;
   end
end
q_rms_initial = sqrt(mean(((z_measured_initial(:)-z_estimated_initial(:))./z_measured_initial(:)).^2));
q_rms2_initial = sqrt(mean(((z_measured_initial(:).^2-z_estimated_initial(:).^2)./z_measured_initial(:))));
title('Initial Data - (From ICCAD Paper) - Error = 8.9%');
hold off;

figure(2);
clf;
subplot(3,1,1);
hold on;
plot(t,z_velocity_initial);
plot(t,y_velocity_filtered,'r');
legend('Input Velocity (Given)','Input Velocity (Filtered)');
ylabel('Velocity (m/s)');
xlabel('Time (s)');
r_filter_velocity_change = (sum(z_velocity_initial)-sum(y_velocity_filtered))/sum(z_velocity_initial);
title('Filtering input of given velocity');
hold off;

subplot(3,1,2);
hold on;
plot(t,z_acceleration_initial);
plot(t,y_acceleration_filtered,'r');
legend('Input Acceleration (Given)','Input Acceleration (Filtered)');
ylabel('Acceleration');
xlabel('Time (s)');
r_filter_acceleration_change = (sum(z_acceleration_initial)-sum(y_acceleration_filtered))/sum(z_acceleration_initial);
title('Filtering input of given acceleration');
hold off;

% subplot(4,1,3);
% hold on;
% plot(t,z_slope_initial);
% plot(t,y_slope_filtered,'r');
% legend('Input Slope (Given)','Input Slope (Filtered)');
% ylabel('Slope (degrees)');
% xlabel('Time (s)');
% r_filter_slope_change = (sum(z_slope_initial)-sum(y_slope_filtered))/sum(z_slope_initial);
% title('Filtering input of given slope');
% hold off;

subplot(3,1,3);
hold on;
plot(t,x_measured_filtered/1000);
plot(t,y_estimated_afterfilter/1000,'r');
legend('Measured Power (Given)','Estimated Power (Filtered)');
ylabel('Battery Power (kW)');
xlabel('Time (s)');
r_filter_results_change = abs(sum(x_measured_filtered)-sum(y_estimated_afterfilter))/sum(x_measured_filtered);
q_rms_filter_results = sqrt(nanmean(((x_measured_filtered(:)-y_estimated_afterfilter(:))./x_measured_filtered(:)).^2));
title('Filtering output after filtering input data - Error = 8.5%');
hold off;

% figure(3);
% clf;
% scatter(y_velocity_filtered,x_measured_filtered/1000);
% w_coef_speed = regress(x_measured_filtered,y_velocity_filtered);
% hold on;
% plot(1:1:9,(1:1:9)*w_coef_speed/1000,'r');
% hold off;
% legend('Scatter of Power and Velocity', 'Regression Line');
% ylabel('Battery Power (kW)');
% xlabel('Velocity (m/s)');
% title('Regression as recalculated in a\_velocity.m from ICCAD paper');

figure(3);
clf;
hold on;
t = 0.1:0.1:150;
plot(t,x_measured_filtered/1000);
plot(t,x_estimated_recalc_filtered/1000,'r');
legend('Measured Power from Battery','Estimated Power calculated');
ylabel('Battery Power (kW)');
xlabel('Time (s)');
r_current_error = abs(sum(x_measured_filtered)-sum(x_estimated_recalc_filtered))/sum(x_measured_filtered);
q_rms_current_results = sqrt(nanmean(((x_measured_filtered(:)-x_estimated_recalc_filtered(:))./x_measured_filtered(:)).^2));
title('Current Results after filtering inputs and modified coefficients - Error = 5.8%');
hold off;


%% Test change measured
measured_modified = measured;
estimated_modified = estimated;
for i = 1:length(measured_modified)
    if measured_modified(i) == 0
        measured_modified(i) = 1;
        estimated_modified(i) = 1;
    end
end

%% xcorr and rmse
xcorr1 = @(x,y)((max(abs(xcorr(x,y))))/(norm(x,2)*norm(y,2)));
isNotZero = @(x)(x==0)*.00000001+x;
xSetYZero = @(x,y) (not(x==0).*y);
rmse = @(x,y)(sqrt(nanmean((abs((x-y)./x)).^2))); %x is measured , y is estimated.
rmse2 = @(x,y)(sqrt(nanmean(((isNotZero(x)-y)./isNotZero(x)).^2)));

error3 = @(x,y)(abs(x-y)./isNotZero(x));
rmse3 = @(x,y)(sqrt(mean(error3(x,y).^2)));

error4 = @(x,y)(abs(x-xSetYZero(x,y))./x);
rmse4 = @(x,y)(sqrt(nanmean(error4(x,y).^2)));

rmse5 = @(x,y)(sqrt(nansum((x-y).^2)/length(x)));

xcorr_initial = xcorr1(z_measured_initial,z_estimated_initial)
xcorr_filtered = xcorr1(x_measured_filtered,y_estimated_afterfilter)
xcorr_current = xcorr1(x_measured_filtered,x_estimated_recalc_filtered)


 max(abs(xcov(x_measured_filtered,x_estimated_recalc_filtered,'coeff')))