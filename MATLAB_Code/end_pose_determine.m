function [end_pose_mat, track_flag] = end_pose_determine(x_disc, y_disc, z_disc, link, disc_radius)
    sin1=y_disc/sqrt(x_disc^2+y_disc^2);
    cos1=x_disc/sqrt(x_disc^2+y_disc^2);
    
    if ((x_disc - (disc_radius + link(4)) * cos1)^2 + (y_disc - (disc_radius + link(4)) * sin1)^2 + (z_disc - link(1))^2)>(link(2) + link(3))^2
        if z_disc > 70
            distance = sqrt((x_disc - (disc_radius + link(4)) * cos1)^2 + (y_disc - (disc_radius + link(4)) * sin1)^2 + (z_disc - link(1))^2);
            x_config = (link(2) + link(3)) / distance * (x_disc - (disc_radius + link(4)) * cos1) + link(4) * cos1;
            y_config = (link(2) + link(3)) / distance * (y_disc - (disc_radius + link(4)) * sin1) + link(4) * sin1;
            z_config = (link(2) + link(3)) / distance * (z_disc - link(1)) + link(1);
        else
            x_config = (sqrt((link(2) + link(3))^2 - (z_disc - link(1))^2) + link(4)) * cos1;
            y_config = (sqrt((link(2) + link(3))^2 - (z_disc - link(1))^2) + link(4)) * sin1;
            z_config = z_disc
        end
        track_flag = 0;
    else
        x_config = x_disc - disc_radius * cos1;
        y_config = y_disc - disc_radius * sin1;
        z_config = z_disc;
        track_flag = 1;
    end
        
    end_pose_mat =[cos1, 0, sin1, x_config;
                  -sin1, 0, cos1, y_config;
                  0, 1, 0, z_config;
                  0, 0, 0, 1]; 
end

