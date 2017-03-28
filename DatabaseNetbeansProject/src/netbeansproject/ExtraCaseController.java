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
public class ExtraCaseController implements Initializable {

    @FXML
    private Label formFactor;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    }    

    /**
     * @param formFactor the formFactor to set
     */
    public void setFormFactor(String formFactor) {
        this.formFactor.setText(formFactor);
    }
    
}
