function pose_mat = pos_Construct(pos)
    trans_mat = [1, 0, 0, pos(1);
                0, 1, 0, pos(2);
                0, 0, 1, pos(3);
                0, 0, 0, 1];
    rotx = [1, 0, 0, 0;
            0, cos(pos(4)), -sin(pos(4)), 0;
            0, sin(pos(4)), cos(pos(4)), 0;
            0, 0, 0, 1];
    roty = [cos(pos(5)), 0, sin(pos(5)), 0;
            0, 1, 0, 0
            -sin(pos(5)), 0, cos(pos(5)), 0;
            0, 0, 0, 1];
    rotz = [cos(pos(6)), -sin(pos(6)), 0, 0;
            sin(pos(6)), cos(pos(6)), 0, 0;
            0, 0, 1, 0;
            0, 0, 0, 1];

    pose_mat = rotz * roty * rotx * trans_mat;
end

