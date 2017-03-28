/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package netbeansproject;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;

/**
 * FXML Controller class
 *
 * @author Lagoni
 */
public class ExtraCpuController implements Initializable {
    @FXML
    private Label socket;
    @FXML
    private Label clockSpeed;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    }    

    /**
     * @param socket the socket to set
     */
    public void setSocket(String socket) {
        this.socket.setText(socket);
    }

    /**
     * @param clockSpeed the clockSpeed to set
     */
    public void setClockSpeed(String clockSpeed) {
        this.clockSpeed.setText(clockSpeed);
    }

    
}
