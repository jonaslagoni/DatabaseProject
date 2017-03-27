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
    private String url;
    private String port;
    private String database;
    private String username;
    private String password;
    private Connection con;
    
    /**
     * inits some standard values
     */
    public DatabaseController(){
        url = "localhost";
        port = "5432";
        database = "project";
        username = "postgres";
        password = "456852";
    }
    
    /**
     * lets make the connection
     * @return boolean if connected or not.
     */
    public boolean makeConnection(){
        try {
            con = DriverManager.getConnection("jdbc:postgresql://" + url + ":" + port + "/" + database, username, password);
            return true;
        } catch (SQLException ex) {
            System.out.println(ex);
            return false;
        }
    }
    
    /**
     * @return the con
     */
    public Connection getCon() {
        return con;
    }

    /**
     * @return the url
     */
    public String getUrl() {
        return url;
    }

    /**
     * @param url the url to set
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * @return the port
     */
    public String getPort() {
        return port;
    }

    /**
     * @param port the port to set
     */
    public void setPort(String port) {
        this.port = port;
    }

    /**
     * @return the database
     */
    public String getDatabase() {
        return database;
    }

    /**
     * @param database the database to set
     */
    public void setDatabase(String database) {
        this.database = database;
    }

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }
}
