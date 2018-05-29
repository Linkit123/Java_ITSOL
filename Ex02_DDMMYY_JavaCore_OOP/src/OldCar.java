
public class OldCar extends Car {
	String action_duration;

	public String getaction_duration() {
		return action_duration;
	}

	public void setaction_duration(String action_Duration) {
		action_Duration = action_Duration;
	}
	
	
	public void showCarInfo() {
		super.showCarInfo();
		System.out.printf("%s",action_duration);
	}
}
