import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Car {
	long number_Plate;
	int year_of_manufacture;
	String brand;
	int have_Insurance;
	String cart_type;
	String name;
	String packages;
	String package_type;
	int id;

	public Car(long number_Plate, int year_of_manufacture, String brand, int have_Insurance, String cart_type,
			String packages, String package_type) {
		super();
		this.number_Plate = number_Plate;
		this.year_of_manufacture = year_of_manufacture;
		this.brand = brand;
		this.have_Insurance = have_Insurance;
		this.cart_type = cart_type;
		this.packages = packages;
		this.package_type = package_type;
	}
	public Car() {
		super();
		this.number_Plate = number_Plate;
		this.year_of_manufacture = year_of_manufacture;
		this.brand = brand;
		this.have_Insurance = have_Insurance;
		this.cart_type = cart_type;
		this.packages = packages;
		this.package_type = package_type;
	}
	public void showCarInfo() {
		System.out.printf("%s %d %s %s %s %s %n",number_Plate,year_of_manufacture,brand,have_Insurance,packages,package_type);
	}
	public long getNumber_Plate() {
		return number_Plate;
	}
	public void setNumber_Plate(long number_Plate) {
		this.number_Plate = number_Plate;
	}
	public int getYear_of_manufacture() {
		return year_of_manufacture;
	}
	public void setYear_of_manufacture(int year_of_manufacture) {
		this.year_of_manufacture = year_of_manufacture;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public int getHave_Insurance() {
		return have_Insurance;
	}
	public void setHave_Insurance(int have_Insurance) {
		this.have_Insurance = have_Insurance;
	}
	public String getCart_type() {
		return cart_type;
	}
	public void setCart_type(String cart_type) {
		this.cart_type = cart_type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPackages() {
		return packages;
	}
	public void setPackages(String packages) {
		this.packages = packages;
	}
	public String getPackage_type() {
		return package_type;
	}
	public void setPackage_type(String package_type) {
		this.package_type = package_type;
	}
	
}
