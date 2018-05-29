package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

import model.ConnectDB;
import model.Student;
import model.ThongTinQuanLy;

public class Handler {
	Connection conn = null;

	public void connect() {
		ConnectDB db = new ConnectDB();
		conn = db.connect();
	}

	public void disConnect() {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void handler() {
		Scanner sc = new Scanner(System.in);
		boolean flag = true;
		do {
			int number;
			System.out.println("Chuc nang 1: loc danh sach hoc vien theo lop: 		Nhap 1");
			System.out.println("Chuc nang 2: tim kiem hoc vien theo ten: 		Nhap 2");
			System.out.println("Chuc nang 3: tim kiem hoc vien theo SDT: 		Nhap 3");
			System.out.println("Chuc nang 4: tim kiem hoc vien theo email: 		Nhap 4");
			System.out.println("Chuc nang 5: sap xep hoc vien theo ten: 		Nhap 5");
			System.out.println("Chuc nang 6: sap xep hoc vien theo SDT: 		Nhap 6");
			System.out.println("Chuc nang 7: sap xep hoc vien theo email: 		Nhap 7");
			System.out.println("Chuc nang 8: insert Student:			 	Nhap 8");
			System.out.println("Chuc nang 9: delete Student: 				Nhap 9");
			System.out.println("Chuc nang 10: update Student: 				Nhap 10");
			number = sc.nextInt();
			switch (number) {
			case 1:
				filterClass();
				break;

			case 2:
				findName();
				break;

			case 3:
				findSDT();
				break;

			case 4:
				findEmail();
				break;

			case 5:
				sortName();
				break;

			case 6:
				sortSDT();
				break;

			case 7:
				sortEmail();
				break;

			case 8:
				insertStudent();
				break;

			case 9:
				deleteStudent();
				break;

			case 10:
				updateStudent();
				break;

			default:
				System.out.println("Exit");
				break;
			}
		} while (flag = true);
	}

	private void updateStudent() {
		ThongTinQuanLy ttql = new ThongTinQuanLy();
		connect();
		Student st = new Student();
		int id;
		Scanner sc = new Scanner(System.in);
		System.out.println("nhap id muon update");
		id = sc.nextInt();
		String update = "update hocvien set account=?,hoten=?,email=?,sdt=?,lop=?,ghichu=? where id='"+ id +"'";
		st.nhap();
		try {
			PreparedStatement prepareStatement = conn.prepareStatement(update);
			prepareStatement.setString(1, ttql.getAccount());
			prepareStatement.setString(2, st.hoten);
			prepareStatement.setString(3, st.email);
			prepareStatement.setInt(4, st.sdt);
			prepareStatement.setString(5, st.lop);
			prepareStatement.setString(6, st.ghichu);
			prepareStatement.executeUpdate();
			System.out.println("update successful");
		} catch (SQLException e) {
			System.out.println("id an exist");
		}

	}

	private void deleteStudent() {
		connect();
		int id;
		Scanner sc = new Scanner(System.in);
		System.out.println("nhap id muon xoa");
		id = sc.nextInt();
		String delete = "delete hocvien where id = '"+ id +"'";
		try {
			PreparedStatement prepareStatement = conn.prepareStatement(delete);
			ResultSet rs = prepareStatement.executeQuery();
			System.out.println("delete successful");
		} catch (SQLException e) {
			System.out.println("id an exist");
		}

	}

	private void insertStudent() {
		ThongTinQuanLy ttql = new ThongTinQuanLy();
		connect();
		Student st = new Student();
		String insert = "insert into hocvien values(?,?,?,?,?,?,?)";
		try {
			st.nhap();
			PreparedStatement prepareStatement = conn.prepareStatement(insert);
			prepareStatement.setString(1, ttql.getAccount());
			prepareStatement.setInt(2, st.id);
			prepareStatement.setString(3, st.hoten);
			prepareStatement.setString(4, st.email);
			prepareStatement.setInt(5, st.sdt);
			prepareStatement.setString(6, st.lop);
			prepareStatement.setString(7, st.ghichu);
			ResultSet rs = prepareStatement.executeQuery();
			System.out.println("insert successful");
		} catch (SQLException e) {
			System.out.println("id an exist");
		}
	}

	private void sortEmail() {
		ThongTinQuanLy ttql = new ThongTinQuanLy();
		connect();
		String sql = "select * from hocvien order BY email asc";
		Student st = new Student();
		try {
			PreparedStatement prepareStatement = conn.prepareStatement(sql);
			ResultSet rs = prepareStatement.executeQuery();
			if(rs.next() == true) {
			System.out.println("account		" + "id		" + "hoten		" + "email		" + "sdt	" + "lop	"
					+ "ghichu		");
			while (rs.next()) {
				try {
					st.account = ttql.getAccount();
					st.id = rs.getInt("ID");
					st.hoten = rs.getString("hoten");
					st.email = rs.getString("email");
					st.sdt = rs.getInt("sdt");
					st.lop = rs.getString("lop");
					st.ghichu = rs.getString("ghichu");
					System.out.println(st.account + "		" + st.id + "		" + st.hoten + "		" + st.email
							+ "		" + st.sdt + "	" + st.lop + "	" + st.ghichu);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			}else {
				System.out.println("invalid email");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	private void sortSDT() {
		ThongTinQuanLy ttql = new ThongTinQuanLy();
		connect();
		String sql = "select * from hocvien order BY SDT asc";
		Student st = new Student();
		try {
			PreparedStatement prepareStatement = conn.prepareStatement(sql);
			ResultSet rs = prepareStatement.executeQuery();
			if(rs.next() == true) {
			System.out.println("account		" + "id		" + "hoten		" + "email		" + "sdt	" + "lop	"
					+ "ghichu		");
			while (rs.next()) {
				try {
					st.account = ttql.getAccount();
					st.id = rs.getInt("ID");
					st.hoten = rs.getString("hoten");
					st.email = rs.getString("email");
					st.sdt = rs.getInt("sdt");
					st.lop = rs.getString("lop");
					st.ghichu = rs.getString("ghichu");
					System.out.println(st.account + "		" + st.id + "		" + st.hoten + "		" + st.email
							+ "		" + st.sdt + "	" + st.lop + "	" + st.ghichu);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			}else {
				System.out.println("invalid sdt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	private void sortName() {
		ThongTinQuanLy ttql = new ThongTinQuanLy();
		connect();
		String sql = "select * from hocvien order BY hoten asc";
		Student st = new Student();
		try {
			PreparedStatement prepareStatement = conn.prepareStatement(sql);
			ResultSet rs = prepareStatement.executeQuery();
			if(rs.next() == true) {
			System.out.println("account		" + "id		" + "hoten		" + "email		" + "sdt	" + "lop	"
					+ "ghichu		");
			while (rs.next()) {
				try {
					st.account = ttql.getAccount();
					st.id = rs.getInt("ID");
					st.hoten = rs.getString("hoten");
					st.email = rs.getString("email");
					st.sdt = rs.getInt("sdt");
					st.lop = rs.getString("lop");
					st.ghichu = rs.getString("ghichu");
					System.out.println(st.account + "		" + st.id + "		" + st.hoten + "		" + st.email
							+ "		" + st.sdt + "	" + st.lop + "	" + st.ghichu);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			}else {
				System.out.println("invalid name");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	private void findEmail() {
		ThongTinQuanLy ttql = new ThongTinQuanLy();
		connect();
		Scanner sc = new Scanner(System.in);
		String em;
		System.out.println("nhap email muon chon loc");
		em = sc.nextLine();
		String sql = "select * from hocvien where email = '" + em + "'";
		Student st = new Student();
		try {
			PreparedStatement prepareStatement = conn.prepareStatement(sql);
			ResultSet rs = prepareStatement.executeQuery();
			if(rs.next() == true) {
			System.out.println("account		" + "id		" + "hoten		" + "email		" + "sdt	" + "lop	"
					+ "ghichu		");
			while (rs.next()) {
				try {
					st.account = ttql.getAccount();
					st.id = rs.getInt("ID");
					st.hoten = rs.getString("hoten");
					st.email = rs.getString("email");
					st.sdt = rs.getInt("sdt");
					st.lop = rs.getString("lop");
					st.ghichu = rs.getString("ghichu");
					System.out.println(st.account + "		" + st.id + "		" + st.hoten + "		" + st.email
							+ "		" + st.sdt + "	" + st.lop + "	" + st.ghichu);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			}else {
				System.out.println("invalid email");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void findSDT() {
		ThongTinQuanLy ttql = new ThongTinQuanLy();
		connect();
		Scanner sc = new Scanner(System.in);
		String sdt;
		System.out.println("nhap SDT muon chon loc");
		sdt = sc.nextLine();
		String sql = "select * from hocvien where SDT = '" + sdt + "'";
		Student st = new Student();
		try {
			PreparedStatement prepareStatement = conn.prepareStatement(sql);
			ResultSet rs = prepareStatement.executeQuery();
			if(rs.next() == true) {
			System.out.println("account		" + "id		" + "hoten		" + "email		" + "sdt	" + "lop	"
					+ "ghichu		");
			while (rs.next()) {
				try {
					st.account = ttql.getAccount();
					st.id = rs.getInt("ID");
					st.hoten = rs.getString("hoten");
					st.email = rs.getString("email");
					st.sdt = rs.getInt("sdt");
					st.lop = rs.getString("lop");
					st.ghichu = rs.getString("ghichu");
					System.out.println(st.account + "		" + st.id + "		" + st.hoten + "		" + st.email
							+ "		" + st.sdt + "	" + st.lop + "	" + st.ghichu);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			}else {
				System.out.println("invalid sdt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void findName() {
		ThongTinQuanLy ttql = new ThongTinQuanLy();
		connect();
		Scanner sc = new Scanner(System.in);
		String ten;
		System.out.println("nhap ho ten muon chon loc");
		ten = sc.nextLine();
		String sql = "select * from hocvien where hoten = '" + ten + "'";
		Student st = new Student();
		try {
			PreparedStatement prepareStatement = conn.prepareStatement(sql);
			ResultSet rs = prepareStatement.executeQuery();
			if(rs.next() == true) {
			System.out.println("account		" + "id		" + "hoten		" + "email		" + "sdt	" + "lop	"
					+ "ghichu		");
			while (rs.next()) {
				try {
					st.account = ttql.getAccount();
					st.id = rs.getInt("ID");
					st.hoten = rs.getString("hoten");
					st.email = rs.getString("email");
					st.sdt = rs.getInt("sdt");
					st.lop = rs.getString("lop");
					st.ghichu = rs.getString("ghichu");
					System.out.println(st.account + "		" + st.id + "		" + st.hoten + "		" + st.email
							+ "		" + st.sdt + "	" + st.lop + "	" + st.ghichu);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			}else {
				System.out.println("invalid hoten");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void filterClass() {
		ThongTinQuanLy ttql = new ThongTinQuanLy();
		connect();
		Scanner sc = new Scanner(System.in);
		String lop;
		System.out.println("nhap lop muon chon loc");
		lop = sc.nextLine();
		String sql = "select * from hocvien where lop = '" + lop + "'";
		Student st = new Student();
		try {
			PreparedStatement prepareStatement = conn.prepareStatement(sql);
			ResultSet rs = prepareStatement.executeQuery();
			if(rs.next() == true) {
			System.out.println("account		" + "id		" + "hoten		" + "email		" + "sdt	" + "lop	"
					+ "ghichu		");
			while (rs.next()) {
				try {
					st.account = ttql.getAccount();
					st.id = rs.getInt("ID");
					st.hoten = rs.getString("hoten");
					st.email = rs.getString("email");
					st.sdt = rs.getInt("sdt");
					st.lop = rs.getString("lop");
					st.ghichu = rs.getString("ghichu");
					System.out.println(st.account + "		" + st.id + "		" + st.hoten + "		" + st.email
							+ "		" + st.sdt + "	" + st.lop + "	" + st.ghichu);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			}else {
				System.out.println("invalid lop");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
