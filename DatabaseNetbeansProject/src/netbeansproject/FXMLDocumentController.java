/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package netbeansproject;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.layout.AnchorPane;

/**
 *
 * @author Lagoni
 */
public class FXMLDocumentController implements Initializable {
    
    private Label label;
    @FXML
    private ListView<AnchorPane> componentsList;
    
    private void handleButtonAction(ActionEvent event) {
        System.out.println("You clicked me!");
        label.setText("Hello World!");
    }
    
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    }    

    @FXML
    private void buyComponent(ActionEvent event) {
    }

    @FXML
    private void restockComponent(ActionEvent event) {
    }

    @FXML
    private void updateComponentsList(ActionEvent event) {
    }
    
}
