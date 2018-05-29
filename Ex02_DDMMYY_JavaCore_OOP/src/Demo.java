import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

public class Demo {
	
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		boolean flag = true;
		do {
		int number;
		System.out.println("Chuc nang 1: nhap 1");
		System.out.println("Chuc nang 2: nhap 2");
		System.out.println("Chuc nang 3: nhap X,Y: X la so xe, Y la so bao hiem");
		System.out.println("Chuc nang 4: nhap 4 X, voi X la filter(0:tat ca, 1:OldCar, 2:MediumCar, 3:ModernCar");
		number = sc.nextInt();
		switch(number) {
				case 1:
					createCar();
					break;
				
				case 2:
					createpackage();
					break;
				
				case 3:
					EditPackage();
					break;
				
				case 4:
					showCarInfo();
					break;
				
				default:
					System.out.println("confirm");
					break;
				}
		}while(flag = true);
	}
	static int count = 0;
	static int i = count + 1;
	static Connection con = null;
	public static void connect() {
		//private Connection conn = null;
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String userName = "usera";
		String passWord = "123456";
			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				con = DriverManager.getConnection(url, userName, passWord);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {			
				e.printStackTrace();
			}
	}
	
	public static void createCar() {
		Car car = new Car();
		connect();
		String selectSql = "select id from Car";
		try {
			   PreparedStatement preparedStatement = con.prepareStatement(selectSql);
			   ResultSet rs = preparedStatement.executeQuery();
			   while (rs.next()) {
				   count++;
			   }
			   
		Random rnd = new Random();
		String insertSql = "insert into Car(ID,name,number_Plate,year_of_manufacture,brand,have_Insurance,cart_type,package,package_type) values(?,?,?,?,?,?,?,?,?)";
		for (i = 0; i < 10; i++) {
		int k=count+i;
		car.name = String.valueOf("Car" +k);
		long min = 10000;
		long max = 99999;
		long range = (max-min)+1;
		car.number_Plate = ((long)(Math.random()*range)+min);
		
		int min1=1980;
		int max1=2012;
		long range1 = (max1-min1)+1;
		car.year_of_manufacture = (int)(Math.random()*range1)+min1;
		
		String[] branlist = {"TOYOTA","BMW","HUYNDAI"};
		int x;
		x = rnd.nextInt(3);
		car.brand = branlist[x];
		
		int y;
		y = rnd.nextInt(2);
		if(y==0) {
			car.have_Insurance=0;
		}
		else {
			car.have_Insurance=1;
		}
		
		if(car.year_of_manufacture>=2005) {
			car.cart_type = "modern_car";
		}
		else if(car.year_of_manufacture>=1996 && car.year_of_manufacture<=2004){
			car.cart_type=	"medium_car";
		}
		else {
			car.cart_type=	"old_car";
			 }
		preparedStatement = con.prepareStatement(insertSql);
		preparedStatement.setInt(1,i+count);
	    preparedStatement.setString(2,car.name );
	    preparedStatement.setLong(3, car.number_Plate);
	    preparedStatement.setInt(4, car.year_of_manufacture);
	    preparedStatement.setString(5, car.brand);
	    preparedStatement.setInt(6, car.have_Insurance);
	    preparedStatement.setString(7,car.cart_type);
	    preparedStatement.setString(8,car.packages);
	    preparedStatement.setString(9,car.package_type);
	    int check = preparedStatement.executeUpdate();	//thuc thi
		if (check != 0) {
		     //System.out.println("create 10 car success !");
		    } else {
		     System.out.println("error !");
		    }
		}
		System.out.println("create 10 car success !");
		}catch (SQLException e) {
			   e.printStackTrace();
			  }
	}
	
		public static void createpackage() {
		Car pk = new Car();
		connect();
		String selectSql = "select id from Car";
		try {
			   PreparedStatement preparedStatement = con.prepareStatement(selectSql);
			   ResultSet rs = preparedStatement.executeQuery();
			   while (rs.next()) {
				   count++;
			   }
	    Random rnd = new Random();
	    
	    for (int j = 0; j <= count; j++) {
	    String updateSql1 = "update Car set package=?,package_type =? where ID = "+j+"";
	 	String[] package_typelist = {"A","B","C"};
	 	int x;
	 	x = rnd.nextInt(3);
	 	if(x==0) {
	 		pk.package_type="A";
	 	}else if(x==1) {
	 		pk.package_type="B";
	 	}else{
	 		pk.package_type="C";
	 	}
	 	
	 	pk.packages = "package"+j;
	 	preparedStatement = con.prepareStatement(updateSql1);
	 	preparedStatement.setString(1,pk.getPackages());
	 	preparedStatement.setString(2,pk.getPackage_type());
	 	updateSql1 = "update Car set package=?,package_type =? where ID = "+j+"";
	 	int check = preparedStatement.executeUpdate(); 				//thuc thi
	 	}
	 	System.out.println("create 10 carpackage success !");
		}catch (SQLException e) {
			   e.printStackTrace();
			  }
	}
	
	public static void EditPackage() {
		Car car = new Car();
		Scanner sc = new Scanner(System.in);
		String id;
		String Packagenhap;
		System.out.println("nhap x: là so xe");
		id=sc.nextLine();
		System.out.println("nhap Y: la so bao hiem A or B or C");
		Packagenhap = sc.nextLine();
		connect();
		try {
			String selectSql = "select * from Car where ID = '"+id+"'";
			PreparedStatement preparedStatement = con.prepareStatement(selectSql);
			ResultSet rsl = preparedStatement.executeQuery();
			while(rsl.next()) {
				    car.id = rsl.getInt("ID");
					car.cart_type = rsl.getString("cart_type");
					car.package_type = rsl.getString("package_type");
					car.have_Insurance = rsl.getInt("have_Insurance");
					//car.year_of_manufacture = rs.getInt("year_of_manufacture");
					//car.brand = rs.getString("brand");
				    //car.name = rs.getString("name");
					
					int chek0 = 0;
					if(car.cart_type.equals("modern_car") && car.package_type.equals("A")) 	
						chek0 = 1;
					if(car.cart_type.equals("medium_car") && car.package_type.equals("B"))   
						chek0 = 1;
					if(car.cart_type.equals("old_car") && car.package_type.equals("C")) 	
						chek0 = 1;
						
					//System.out.println(car.cart_type +" "+ car.package_type +" "+ chek0);
					
					if(chek0==1) {
						   String check1 = "select * from Car where ID = '"+id+"' and package_type = '"+Packagenhap+"' and have_Insurance = 0";
						   preparedStatement = con.prepareStatement(check1);
						   int checkk = preparedStatement.executeUpdate();
						   if(checkk == 0) {
							   System.out.println("Unavailable Buying!");
						   }else 
							   if(checkk == 1){
							   car.have_Insurance =1;
							   String update = "update Car set have_Insurance =? where ID = '"+id+"' and package_type = '"+Packagenhap+"' and have_Insurance = 0";
							   preparedStatement = con.prepareStatement(update);
							   preparedStatement.setInt(1,1);
							   int checkupdate = preparedStatement.executeUpdate();
							   System.out.println("Successful Buying!");
						   }
						   else {
							   System.out.println("Unsuccessful Buying");
						   }
					}else {
						System.out.println("Invalid Package!");
					}
			}   
		 }catch (SQLException e) {
		   e.printStackTrace();
		 }
}
	
	public static void showCarInfo() {
			Scanner sc;
			int chooses;
			System.out.println("Thông tin ô tô phân loại theo :");
			System.out.println("1. Tất cả    2. Đời cũ     3. Đời trung     4. Đời mới    5.Thoát");
			System.out.println("Mời bạn chọn kiểu phân loại : ");
			sc = new Scanner(System.in);
			chooses = sc.nextInt();
			switch(chooses) {
			case 1:
				Car car = new Car();
				addCar();
				break;
			case 2:
				car = new Car();
				addCar1();
				break;
			case 3:
				car = new Car();
				addCar2();
				break;
			case 4:
				car = new Car();
				addCar3();
				break;
			case 5:
			default:
				System.out.println("đã thoát");
				break;
		}
	}

	private static void addCar() {
		connect();
			String selectSql = "select * from Car";
			try {
				Car car = new Car();
				PreparedStatement preparedStatement = con.prepareStatement(selectSql);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
				car.cart_type = rs.getString("cart_type");
				car.package_type = rs.getString("package_type");
				car.have_Insurance = rs.getInt("have_Insurance");
				car.year_of_manufacture = rs.getInt("year_of_manufacture");
				car.brand = rs.getString("brand");
			    car.packages = rs.getString("package");
			    car.package_type = rs.getString("package_type");
			    car = new Car(car.number_Plate, car.year_of_manufacture, car.brand, car.have_Insurance, car.cart_type,car.packages, car.package_type);
			    car.showCarInfo();
				}
			}catch (SQLException e) {
				e.printStackTrace();
		  }
		}
	private static void addCar1() {
		connect();
			String selectSql = "select * from Car where cart_type='old_car'";
			try {
				Car car = new Car();
				PreparedStatement preparedStatement = con.prepareStatement(selectSql);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
				car.cart_type = rs.getString("cart_type");
				car.package_type = rs.getString("package_type");
				car.have_Insurance = rs.getInt("have_Insurance");
				car.year_of_manufacture = rs.getInt("year_of_manufacture");
				car.brand = rs.getString("brand");
			    car.packages = rs.getString("package");
			    car.package_type = rs.getString("package_type");
			    car = new Car(car.number_Plate, car.year_of_manufacture, car.brand, car.have_Insurance, car.cart_type,car.packages, car.package_type);
			    car.showCarInfo();
				}
			}catch (SQLException e) {
				e.printStackTrace();
		  }
	}
	private static void addCar2() {
		connect();
			String selectSql = "select * from Car where cart_type='medium_car'";
			try {
				Car car = new Car();
				PreparedStatement preparedStatement = con.prepareStatement(selectSql);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
				car.cart_type = rs.getString("cart_type");
				car.package_type = rs.getString("package_type");
				car.have_Insurance = rs.getInt("have_Insurance");
				car.year_of_manufacture = rs.getInt("year_of_manufacture");
				car.brand = rs.getString("brand");
			    car.packages = rs.getString("package");
			    car.package_type = rs.getString("package_type");
			    car = new Car(car.number_Plate, car.year_of_manufacture, car.brand, car.have_Insurance, car.cart_type,car.packages, car.package_type);
			    car.showCarInfo();
				}
			}catch (SQLException e) {
				e.printStackTrace();
		  }
	}
	
	private static void addCar3() {
		connect();
			String selectSql = "select * from Car where cart_type='modern_car'";
			try {
				Car car = new Car();
				PreparedStatement preparedStatement = con.prepareStatement(selectSql);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
				car.cart_type = rs.getString("cart_type");
				car.package_type = rs.getString("package_type");
				car.have_Insurance = rs.getInt("have_Insurance");
				car.year_of_manufacture = rs.getInt("year_of_manufacture");
				car.brand = rs.getString("brand");
			    car.packages = rs.getString("package");
			    car.package_type = rs.getString("package_type");
			    car = new Car(car.number_Plate, car.year_of_manufacture, car.brand, car.have_Insurance, car.cart_type,car.packages, car.package_type);
			    car.showCarInfo();
				}
			}catch (SQLException e) {
				e.printStackTrace();
		  }
	}
}

