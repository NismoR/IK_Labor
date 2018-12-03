const double THRESHOLD_GRAB = 0.5;
bool isGrabRight = false;
bool isGrabLeft = false;
void grabTest(Leap::Hand hand, bool isleft) {
	float strength = hand.grabStrength();
	if (isleft){
		if (!isGrabLeft && strength > THRESHOLD_GRAB) {
			sendZoomIn();
			isGrabLeft = true;
			cout << "ZOOM IN\n";
		}			
		else if (isGrabLeft && strength < THRESHOLD_GRAB)
			isGrabLeft = false;
	}
	else {
		if (!isGrabRight && strength > THRESHOLD_GRAB) {
			sendZoomOut();
			isGrabRight = true;
			cout << "ZOOM OUT\n";
		}
		else if (isGrabRight && strength < THRESHOLD_GRAB)
			isGrabRight = false;		
	}
}
