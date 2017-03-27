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
 * @author jonas
 */
public class ComponentController implements Initializable {
    @FXML
    private Label componentId;
    @FXML
    private Label componentName;
    @FXML
    private Label componentPrice;
    @FXML
    private Label componentStock;
    @FXML
    private Label componentPreferedStock;
    @FXML
    private Label componentMinimumStock;
    @FXML
    private Label componentKind;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    }  
    
    /**
     * @param componentKind the componentKind to set
     */
    public void setComponentKind(String componentKind){
        this.componentKind.setText(componentKind);
    }
    
    /**
     * @param componentId the componentId to set
     */
    public void setComponentId(String componentId) {
        this.componentId.setText(componentId);
    }

    /**
     * @param componentName the componentName to set
     */
    public void setComponentName(String componentName) {
        this.componentName.setText(componentName);
    }

    /**
     * @param componentPrice the componentPrice to set
     */
    public void setComponentPrice(String componentPrice) {
        this.componentPrice.setText(componentPrice);
    }

    /**
     * @param componentStock the componentStock to set
     */
    public void setComponentStock(String componentStock) {
        this.componentStock.setText(componentStock);
    }

    /**
     * @param componentPreferedStock the componentPreferedStock to set
     */
    public void setComponentPreferedStock(String componentPreferedStock) {
        this.componentPreferedStock.setText(componentPreferedStock);
    }

    /**
     * @param componentMinimumStock the componentMinimumStock to set
     */
    public void setComponentMinimumStock(String componentMinimumStock) {
        this.componentMinimumStock.setText(componentMinimumStock);
    }

    
}
