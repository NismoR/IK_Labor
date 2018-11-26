function [o,y]=get_t(pos)
z=[67335 66651 65098 88812 73201 106500];
o=pos-z;
o=o.*[-1 -1 1 -1 1 -1];
o(1:3)=o(1:3)/50000;
o(4:6)=o(4:6)/35156;
o=o*90;
o=deg2rad(o);
[o,y]=gt6a_dirgeom(o);
end
