z_count =1;

load('regress_0kg.mat')
for count = 1:y_count-1
    z_kg_acc(z_count,1) = y_kg_acc(count,1);
    z_kg_vel(z_count,1) = y_kg_vel(count,1);
    z_kg_theta(z_count,1) = y_kg_theta(count,1);
    z_mass(z_count,1) = y_mass;
    z_kg_power(z_count,1) = y_kg_power(count,1);
    z_count = z_count+1;
end

load('regress_50kg.mat')
for count = 1:y_count-1
    z_kg_acc(z_count,1) = y_kg_acc(count,1);
    z_kg_vel(z_count,1) = y_kg_vel(count,1);
    z_kg_theta(z_count,1) = y_kg_theta(count,1);
    z_mass(z_count,1) = y_mass;
    z_kg_power(z_count,1) = y_kg_power(count,1);
    z_count = z_count+1;
end

load('regress_120kg.mat')
for count = 1:y_count-1
    z_kg_acc(z_count,1) = y_kg_acc(count,1);
    z_kg_vel(z_count,1) = y_kg_vel(count,1);
    z_kg_theta(z_count,1) = y_kg_theta(count,1);
    z_mass(z_count,1) = y_mass;
    z_kg_power(z_count,1) = y_kg_power(count,1);
    z_count = z_count+1;
end

load('regress_170kg.mat')
for count = 1:y_count-1
    z_kg_acc(z_count,1) = y_kg_acc(count,1);
    z_kg_vel(z_count,1) = y_kg_vel(count,1);
    z_kg_theta(z_count,1) = y_kg_theta(count,1);
    z_mass(z_count,1) = y_mass;
    z_kg_power(z_count,1) = y_kg_power(count,1);
    z_count = z_count+1;
end

load('regress_235kg.mat')
for count = 1:y_count-1
    z_kg_acc(z_count,1) = y_kg_acc(count,1);
    z_kg_vel(z_count,1) = y_kg_vel(count,1);
    z_kg_theta(z_count,1) = y_kg_theta(count,1);
    z_mass(z_count,1) = y_mass;
    z_kg_power(z_count,1) = y_kg_power(count,1);
    z_count = z_count+1;
end

load('regress_road_B.mat')
for count = 1:y_count-1
    z_kg_acc(z_count,1) = y_kg_acc(count,1);
    z_kg_vel(z_count,1) = y_kg_vel(count,1);
    z_kg_theta(z_count,1) = y_kg_theta(count,1);
    z_mass(z_count,1) = y_mass;
    z_kg_power(z_count,1) = y_kg_power(count,1);
    z_count = z_count+1;
end

load('regress_road_C.mat')
for count = 1:y_count-1
    z_kg_acc(z_count,1) = y_kg_acc(count,1);
    z_kg_vel(z_count,1) = y_kg_vel(count,1);
    z_kg_theta(z_count,1) = y_kg_theta(count,1);
    z_mass(z_count,1) = y_mass;
    z_kg_power(z_count,1) = y_kg_power(count,1);
    z_count = z_count+1;
end

load('regress_road_D.mat')
for count = 1:y_count-1
    z_kg_acc(z_count,1) = y_kg_acc(count,1);
    z_kg_vel(z_count,1) = y_kg_vel(count,1);
    z_kg_theta(z_count,1) = y_kg_theta(count,1);
    z_mass(z_count,1) = y_mass;
    z_kg_power(z_count,1) = y_kg_power(count,1);
    z_count = z_count+1;
end

% load('regress_validation_1.mat')
% for count = 1:y_count-1
%     z_kg_acc(z_count,1) = y_kg_acc(count,1);
%     z_kg_vel(z_count,1) = y_kg_vel(count,1);
%     z_kg_theta(z_count,1) = y_kg_theta(count,1);
%     z_mass(z_count,1) = y_mass;
%     z_kg_power(z_count,1) = y_kg_power(count,1);
%     z_count = z_count+1;
% end