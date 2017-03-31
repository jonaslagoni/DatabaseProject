/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package netbeansproject;

import java.io.IOException;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
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
import javafx.scene.layout.Pane;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;
import netbeansproject.coreobjects.Case;
import netbeansproject.coreobjects.Component;
import netbeansproject.coreobjects.Cpu;
import netbeansproject.coreobjects.Mainboard;
import netbeansproject.coreobjects.Ram;
import netbeansproject.databasecore.DatabaseController;

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
    private VBox componentTypeAnchorPane;
    private Component component;
    private Pane parentRoot;
    private SystemController parentController;
    private DatabaseController databaseController;
    @FXML
    private StackPane mainPanel;
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
    @FXML
    private VBox vboxExtrainfo;
    @FXML
    private Label componentRealPrice;
    
    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
        mainPanel.addEventHandler(MouseEvent.MOUSE_PRESSED, new EventHandler<MouseEvent>(){
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
            if(parentRoot != null){
                parentRoot.setPrefHeight(parentRoot.getPrefHeight()-125);
                parentController.setToogleHeight(parentController.getToogleHeight()-125);
            }
        }else{
            root.getChildren().add(extraInfoStackPane);
            root.setPrefHeight(175);
            root.setMaxHeight(175);
            if(parentRoot != null){
                parentRoot.setPrefHeight(parentRoot.getPrefHeight()+125);
                parentController.setToogleHeight(parentController.getToogleHeight()+125);
            }
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
        componentNameEdit.setText(componentName);
    }

    /**
     * @param componentPrice the componentPrice to set
     */
    public void setComponentPrice(String componentPrice) {
        this.componentPrice.setText(componentPrice);
    }

    /**
     * @param componentPrice the componentPrice to set
     */
    public void setComponentRealPrice(String componentPrice) {
        this.componentRealPrice.setText(componentPrice);
        componentPriceEdit.setText(componentPrice);
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
        double oldPrice = Double.parseDouble(componentPrice.getText());
        String updateStatement = "UPDATE component " +
        "SET name=?, price=? " +
        "WHERE componentid = "+ componentId.getText() + ";";
        if(FXMLDocumentController.isDouble(componentPriceEdit.getText(), 2, 8)){
            try {
                PreparedStatement preparedStatementInsert = databaseController.getCon().prepareStatement(updateStatement, Statement.RETURN_GENERATED_KEYS);
                preparedStatementInsert.setString(1, componentNameEdit.getText());
                preparedStatementInsert.setDouble(2, Double.parseDouble(componentPriceEdit.getText()));
                preparedStatementInsert.executeUpdate();
                componentName.setText(componentNameEdit.getText());
                componentPrice.setText(componentPriceEdit.getText());
                if(parentController != null){
                    parentController.setTotalPrice(parentController.getTotalPrice() - (oldPrice - Double.parseDouble(componentPriceEdit.getText())));
                    parentController.setTotalPrice();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    /**
     * @param componentType the componentType to set
     */
    public void setComponentType(ComponentType componentType) {
        try {
            this.componentType = componentType;
            if(componentTypeAnchorPane != null){
                vboxExtrainfo.getChildren().remove(componentTypeAnchorPane);
            }
            switch(componentType){
                case CPU:
                    FXMLLoader loader = new FXMLLoader(getClass().getResource("fxml/ExtraCpu.fxml"));
                    componentTypeAnchorPane = (VBox)loader.load();
                    ExtraCpuController cpuController = loader.<ExtraCpuController>getController();
                    cpuController.setClockSpeed("" + FXMLDocumentController.round(((Cpu)component).getClockSpeed(), 2));
                    cpuController.setSocket(((Cpu)component).getSocket());
                    break;
                case RAM:
                    loader = new FXMLLoader(getClass().getResource("fxml/ExtraRam.fxml"));
                    componentTypeAnchorPane = (VBox)loader.load();
                    ExtraRamController ramController = loader.<ExtraRamController>getController();
                    ramController.setRamType(((Ram)component).getRamType());
                    ramController.setBusSpeed("" + ((Ram)component).getBusSpeed());
                    break;
                case MAINBOARD:
                    loader = new FXMLLoader(getClass().getResource("fxml/ExtraMainboard.fxml"));
                    componentTypeAnchorPane = (VBox)loader.load();
                    ExtraMainboardController mainboardController = loader.<ExtraMainboardController>getController();
                    mainboardController.setFormFactor(((Mainboard)component).getFormFactor());
                    mainboardController.setOnBoardGraphics("" + ((Mainboard)component).isOnBoardGraphics());
                    mainboardController.setRamType(((Mainboard)component).getRamType());
                    mainboardController.setSocket(((Mainboard)component).getSocket());
                    break;
                case CASE:
                    loader = new FXMLLoader(getClass().getResource("fxml/ExtraCase.fxml"));
                    componentTypeAnchorPane = (VBox)loader.load();
                    ExtraCaseController caseController = loader.<ExtraCaseController>getController();
                    caseController.setFormFactor(((Case)component).getFormFactor());
                    break;
            }
            if(componentTypeAnchorPane != null){
                vboxExtrainfo.getChildren().add(componentTypeAnchorPane);
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    /**
     * @param component the component to set
     */
    public void setComponent(Component component) {
        this.component = component;
    }

    /**
     * @param databaseController the databaseController to set
     */
    public void setDatabaseController(DatabaseController databaseController) {
        this.databaseController = databaseController;
    }

    /**
     * @param parentRoot the parentRoot to set
     */
    public void setParentRoot(Pane parentRoot) {
        this.parentRoot = parentRoot;
    }

    /**
     * @param parentController the parentController to set
     */
    public void setParentController(SystemController parentController) {
        this.parentController = parentController;
    }

}
