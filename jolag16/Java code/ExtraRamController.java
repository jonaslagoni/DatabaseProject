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
public class ExtraRamController implements Initializable {
    @FXML
    private Label ramType;
    @FXML
    private Label busSpeed;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    }    

    /**
     * @param ramType the ramType to set
     */
    public void setRamType(String ramType) {
        this.ramType.setText(ramType);
    }

    /**
     * @param busSpeed the busSpeed to set
     */
    public void setBusSpeed(String busSpeed) {
        this.busSpeed.setText(busSpeed);
    }

    
}
