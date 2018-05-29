package controller;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import model.ConnectDB;
import model.ThongTinQuanLy;

public class AccountAlready {
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

	public void AccountAlready1() {
		connect();
		String first = null;
		String last = null;
		String em = null;
		// lay ngay hien tai
		Date today = new Date(System.currentTimeMillis());
		SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss dd/MM/yyyy");
		String s = timeFormat.format(today.getTime());

		ThongTinQuanLy ttql = new ThongTinQuanLy();
		ttql.nhap();
		String selectSql1 = "select * from quanly where account = '" + ttql.account + "'";
		try {
			PreparedStatement prepareStatement = conn.prepareStatement(selectSql1);
			ResultSet rs = prepareStatement.executeQuery();
			if (rs.next()) {
				first = rs.getString("firstname");
				last = rs.getString("lastname");
				em = rs.getString("email");
				if(ttql.firstname.equals(first) && ttql.lastname.equals(last) && ttql.email.equals(em)) {
					System.out.println("login successfull");
				}else {
					try {
						String updatesql = "update quanly set firstname=?, lastname=?, email=?, editdate=? where account = '"+ttql.account+"'";
						prepareStatement = conn.prepareStatement(updatesql);
						prepareStatement.setString(1, ttql.firstname);
						prepareStatement.setString(2, ttql.lastname);
						prepareStatement.setString(3, ttql.email);
						prepareStatement.setString(4, s);
						prepareStatement.executeUpdate();
						System.out.println("account already exist, update account successful");
						AccountAlready1();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				
			} else {
				System.out.println("invalid account.");
				AccountAlready1();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}