public class Record {
	
	float[] values = new float[10];
	boolean full = false;
	
	Record() {
		
		println("New record created");
		
		for (int i = 0; i < values.length; i++) {
			values[i] = -1;
    }
		
	}
	
	void add(float value) {
		
		boolean lucky = false;
		
		for (int i = 0; i < values.length; i++) {
			
			if (values[i] == -1) {
				values[i] = map(value, 0, interfaceFanMaxValue, 0, 255);
				println("added value " + value);
				delay(1000);
				break;
			}
			
    }

		for (int j = 0; j < values.length; j++) {
			
			if (values[j] == -1) {
				lucky = true;
			}
			
		}
		
		if (lucky == false) {
			
			full = true;
			println("Record done");
			
			for (int k = 0; k < presenceChecker.values.length; k++) {
				presenceChecker.values[k] = 0;
		  }
		
		}
		
	}
	
}