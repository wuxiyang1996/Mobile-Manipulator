close all; clear all; clc;

t = 0: 0.01:0.5;

%% Disc Initialize 
radius = 10;
gripper = 12;
% pos_Init = [100, -100, 105];
% velocity_Init = [-200, 400, 100];

pos_Init = [50, -100, 120];
velocity_Init = [0, 400, 0];

x_disc = pos_Init(1) + velocity_Init(1) * t;
y_disc = pos_Init(2) + velocity_Init(2) * t;
z_disc = pos_Init(3) + velocity_Init(3) * t - 0.5 * 980 * t .* t;

%% Pincher Initialize

L1 = Revolute('d', 12.0, 'a', 0, 'alpha', pi/2);
L2 = Revolute('d', 0, 'a', 31.5, 'alpha', 0, 'offset', pi/2, 'qlim',[-pi/2 pi/2]);
L3 = Revolute('d', 0, 'a', 31.5, 'alpha', 0, 'qlim',[-pi/3 pi/3]);
L4 = Revolute('d', 0, 'a', 19.5, 'alpha', 0, 'qlim',[-pi/3 pi/3]);

pincher = SerialLink([L1, L2, L3, L4]);
pincher.name = 'Pincher';

%% Jacobian Matrix
init_ang=[0, 0, 0, 0];
pos = pincher.fkine(init_ang);
jaco = pincher.jacob0(init_ang);
[trans_mat, jacobian] = user_jacobian([12, 31.5, 31.5, 19.5], init_ang);

%% Simulation
fig = figure;
q_save = zeros(50, 4);
for i = 1:50
    %disc_display(x_disc(i), y_disc(i), z_disc(i));
    plot3(x_disc(i), y_disc(i), z_disc(i), 'r+'); 
    hold on;
    [end_pose_mat, track_flag] = end_pose_determine(x_disc(i), y_disc(i), z_disc(i), [12, 31.5, 31.5, 19.5], gripper + radius);
    if (track_flag == 1) & (gripper >= 0)
        gripper = gripper - 2;
    end
    [q_ter,err(i)] =pincher.ikcon(end_pose_mat);
    pos_t = pincher.fkine(q_ter);
    plot3(pos_t(1, 4), pos_t(2, 4), pos_t(3, 4), 'b+');

    pincher.plot(q_ter);
    if (gripper == 2)
        break;
    end
    %hold off;
    q_save(i, :) = q_ter;

    frame = getframe(fig);
    img = frame2im(frame);
    imwrite(img, ['Images/', num2str(floor(i/100)), num2str(floor(mod(i, 100)/10)), num2str(mod(i, 10)), '.jpg']);
end
i = i - 1

%% Joint Space
% subplot(4,1,1);
% plot(q_save(1:i,1));
% title('Joint 1 Angle');
% grid on;
% subplot(4,1,2);
% plot(q_save(1:i,2));
% title('Joint 2 Angle');
% grid on;
% subplot(4,1,3);
% plot(q_save(1:i,3));
% title('Joint 3 Angle');
% grid on;
% subplot(4,1,4);
% plot(q_save(1:i,4));
% title('Joint 4 Angle');
% grid on;

