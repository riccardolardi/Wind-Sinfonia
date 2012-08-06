public class Fan {
	
	int id, pin, xpos, ypos;
	float value;
	
	Fan(int inId, int inPin) {
		
		id = inId;
		pin = inPin;
		
		println("Fan " + id + " initialized at pin " + pin);
		
	}
	
	void gotoValue(float inValue) {

		value = inValue;
		arduino.analogWrite(pin, int(value));
		
	}
	
}