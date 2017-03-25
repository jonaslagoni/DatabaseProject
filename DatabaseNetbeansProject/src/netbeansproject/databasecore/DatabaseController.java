/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package netbeansproject.databasecore;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Lagoni
 */
public class DatabaseController {
    private Connection con;
    public DatabaseController(){
        String url = "jdbc:postgresql://localhost:5432/project";
        String user = "postgres";
        String password = "456852";
        //CONNECTING
        try {
            con = DriverManager.getConnection(url, user, password);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }
    
    /**
     * @return the con
     */
    public Connection getCon() {
        return con;
    }
}
