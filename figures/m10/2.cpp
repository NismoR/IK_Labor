const double THRESHOLD_ANGLE_TO = PI/2;
void processSwipe(Leap::Vector vector, bool isleft) {
	cout<<vector<< " Mozgas!!!!" << endl;
	//(x oldalra) (y felfele) (z elore hatra) 
	Leap::Vector jobb(1, 0, 0);
	Leap::Vector bal(-1, 0, 0);
	Leap::Vector fel(0, 1, 0);
	Leap::Vector le(0, -1, 0);
	double dir[4];
	dir[0] = vector.angleTo(jobb);
	dir[1] = vector.angleTo(bal);
	dir[2] = vector.angleTo(fel);
	dir[3] = vector.angleTo(le);
	double min = 2 * PI;
	int min_i = 0;
	for (int i = 0; i < 4; i++) {
		if (min > dir[i]) {
			min = dir[i];
			min_i = i;
		}
	}
	cout <<"angle: "<< min << endl;
	if (dir[min_i] > THRESHOLD_ANGLE_TO)
		return;
	switch (min_i)
	{
	case 0:
		cout << "jobb" << endl;
		sendSwipeRight();
		break;
	case 1:
		cout << "bal" << endl;
		sendSwipeLeft();
		break;
	case 2:
		cout << "fel" << endl;
		sendSwipeUp();
		break;
	case 3:
		cout << "le" << endl;
		sendSwipeDown();
		break;
	default:
		break;
	}
}
