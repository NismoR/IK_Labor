const double THRESHOLD_GRAB_TIME = 800;
clock_t first_click_time = 0;

void grabTest(Leap::Hand hand, bool isleft) {
	clock_t this_time = clock();
	float strength = hand.grabStrength();

	if (grab_counter == 0) {
		if (!isGrabLeft && strength > THRESHOLD_GRAB) {
			first_click_time = clock();
			grab_counter++;
		}
	}
	else {
		if (!isGrabLeft && strength > THRESHOLD_GRAB) {
			grab_counter++;
		}
	}
	if (isGrabLeft && strength < THRESHOLD_GRAB) {
		isGrabLeft = false;
	}
	if ((this_time - first_click_time) > THRESHOLD_GRAB_TIME) {
		switch (grab_counter) {
		case 0:
			break;
		case 1:
			sendZoomIn();
			cout << "ZOOM IN\n";
			break;
		default:
			sendZoomOut();
			cout << "ZOOM OUT\n";
		}
		grab_counter = 0;
	}	
}
