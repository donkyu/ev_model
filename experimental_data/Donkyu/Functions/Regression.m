B(1,1) = 0.64;
B(2,1) = 9.8;
B(3,1) = 1.2;

% % without mass
% Size_of_y = size(y_kg_acc);
% num_y = Size_of_y(1,1);
% for count = 1:100
%     Q = (B(1,1)+B(2,1)*sind(y_kg_theta)+B(3,1)*y_kg_acc)*y_mass;
%     X = [y_mass*y_kg_vel y_mass*sind(y_kg_theta).*y_kg_vel y_mass*y_kg_acc.*y_kg_vel ones(num_y,1) y_kg_vel y_kg_vel.^2 Q.^2];
%     Y = y_kg_power;
% 
%     B = regress(Y,X)
% end


% with mass
Size_of_z = size(z_kg_acc);
num_z = Size_of_z(1,1);
for count = 1:100
    Q = (B(1,1)+B(2,1)*sind(z_kg_theta)+B(3,1)*z_kg_acc).*z_mass;
    X = [z_mass.*z_kg_vel z_mass.*sind(z_kg_theta).*z_kg_vel z_mass.*z_kg_acc.*z_kg_vel ones(num_z,1) z_kg_vel z_kg_vel.^2 Q.^2];
    Y = z_kg_power;

    B = regress(Y,X)
end
