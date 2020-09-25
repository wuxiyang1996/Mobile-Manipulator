function disc_display(x, y, z)
    radius = 10;
    theta = 0:0.05*pi:2*pi;
    [x_cylinder,y_cylinder,z_cylinder]=cylinder(radius, 50);
    x_circle = radius * cos(theta);
    y_circle = radius * sin(theta);
    z_circle = ones(size(x_circle));
    
    surf(x_cylinder + x, y_cylinder + y, z_cylinder + z);
    hold on;

    fill3(x_circle + x, y_circle + y, z_circle + z, [1,0,0]);
    fill3(x_circle + x, y_circle + y, z_circle + z-1, [1,0,0]);
    hold off;
end

