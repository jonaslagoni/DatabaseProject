/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package netbeansproject;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.StackPane;
import netbeansproject.coreobjects.Component;
import netbeansproject.coreobjects.Cpu;

/**
 * FXML Controller class
 *
 * @author jonas
 */
public class ComponentController implements Initializable {
    public enum ComponentType {
        CPU, RAM, CASE, MAINBOARD, GPU
    };
    private boolean shown;
    private ComponentType componentType;
    private AnchorPane componentTypeAnchorPane;
    private Component component;
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
    @FXML
    private AnchorPane root;
    @FXML
    private StackPane extraInfoStackPane;
    @FXML
    private AnchorPane extraInfoAnchorPane;
    @FXML
    private TextField componentNameEdit;
    @FXML
    private TextField componentPriceEdit;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
        root.addEventHandler(MouseEvent.MOUSE_PRESSED, new EventHandler<MouseEvent>(){
            public void handle(MouseEvent e) {
                toggleExtraInfo();
             }
        });
        shown = true;
        toggleExtraInfo();
    }  
    
    public void toggleExtraInfo(){
        if(shown){
            root.getChildren().remove(extraInfoStackPane);
            root.setMaxHeight(50);
            root.setPrefHeight(50);
        }else{
            root.getChildren().add(extraInfoStackPane);
            root.setPrefHeight(120);
            root.setMaxHeight(120);
        }
        shown = !shown;
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

    @FXML
    private void saveComponentEdits(ActionEvent event) {
    }

    /**
     * @param componentType the componentType to set
     */
    public void setComponentType(ComponentType componentType) {
        try {
            this.componentType = componentType;
            if(componentTypeAnchorPane != null){
                root.getChildren().add(componentTypeAnchorPane);
            }
            FXMLLoader loader = null;
            switch(componentType){
                case CPU:
                    loader = new FXMLLoader(getClass().getResource("fxml/ExtraCpu.fxml"));
                    ExtraCpuController cpuController = loader.<ExtraCpuController>getController();
                    //cpuController.setBusSpeed(((Cpu)component).getClockSpeed() == 0.0 ? "" : "");
                    cpuController.setSocket(((Cpu)component).getSocket());
                    break;
                case RAM:
                    loader = new FXMLLoader(getClass().getResource("fxml/ExtraRam.fxml"));
                    break;
                case MAINBOARD:
                    loader = new FXMLLoader(getClass().getResource("fxml/ExtraMainboard.fxml"));
                    break;
                case CASE:
                    loader = new FXMLLoader(getClass().getResource("fxml/ExtraCase.fxml"));
                    break;
            }
            if(loader != null){
                componentTypeAnchorPane = (AnchorPane)loader.load();
                extraInfoStackPane.getChildren().add(componentTypeAnchorPane);
            }
        } catch (IOException ex) {
            System.out.println(ex);
        }
    }

    /**
     * @param component the component to set
     */
    public void setComponent(Component component) {
        this.component = component;
    }

    
}
