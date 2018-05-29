package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnectDB {
  public Connection con = null;
  //nhan xet
  public Connection connect() {
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
    return con;
  }
}
