package netbeansdatabaseproject;
import java.sql.*;
import java.util.logging.*;

public class DBtest {
	
	public static void main(String[] args) {
		String url = "jdbc:postgresql://localhost:5432/postgres";
		String user = "postgres";
		String password = "456852";
		Connection con = null;

		//CONNECTING
		try {
			con = DriverManager.getConnection(url, user, password);

		} catch (SQLException ex) {
		        Logger lgr = Logger.getLogger(DBtest.class.getName());
    			lgr.log(Level.WARNING, ex.getMessage(), ex);

		}

		testDB(con);
	}

	public static void testDB(Connection con){
		//RUN AN EXAMPLE QUERY
		try {
			Statement st = con.createStatement();
		        String query = "select cast (exp(sin(23)*sin(23)+cos(23)*cos(23))*pi()*(exp(sin(23)*sin(23)+cos(23)*cos(23)+sin(23)*sin(23)+cos(23)*cos(23))+cos(pi()/(sin(23)*sin(23)+cos(23)*cos(23)+sin(23)*sin(23)+cos(23)*cos(23))))*(sin(23)*sin(23)+cos(23)*cos(23)+sin(23)*sin(23)+cos(23)*cos(23))/(sin(23)*sin(23)+cos(23)*cos(23)+sin(23)*sin(23)+cos(23)*cos(23)+sin(23)*sin(23)+cos(23)*cos(23)) as int) as answer";
		        ResultSet rs = st.executeQuery(query);
		        while (rs.next()) {
		            	String answer = rs.getString("answer");
		            	System.out.printf("The answer is %s!\n", answer);
		        }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
