function get_shot_in_pos(s, p,p_i, i, vid)
	set_pos(s,p(p_i,1:6))
	pause(12)
	disp("taking shot")
	frame = getsnapshot(vid);
	imwrite(frame,['calib_' num2str(p_i) '_' num2str(i) '.jpg'])
end
