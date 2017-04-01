/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package netbeansproject;

import java.io.IOException;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.Spinner;
import javafx.scene.control.SpinnerValueFactory;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.Border;
import javafx.scene.layout.BorderStroke;
import javafx.scene.layout.BorderStrokeStyle;
import javafx.scene.layout.BorderWidths;
import javafx.scene.layout.CornerRadii;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import netbeansproject.coreobjects.Case;
import netbeansproject.coreobjects.Cpu;
import netbeansproject.coreobjects.Mainboard;
import netbeansproject.coreobjects.Ram;
import netbeansproject.databasecore.DatabaseController;

/**
 * FXML Controller class
 *
 * @author Lagoni
 */
public class SystemController implements Initializable {

    private boolean shown;
    private DatabaseController databaseController;
    private int toogleHeight = 160;
    private double totalPrice = 0.0;
    private int minInventory = Integer.MAX_VALUE;
    private List<ComponentController> componentControllers;
    private FXMLDocumentController rootController;
    @FXML
    private AnchorPane root;
    @FXML
    private StackPane mainPanel;
    @FXML
    private Label systemId;
    @FXML
    private Label systemName;
    @FXML
    private Label systemPrice;
    @FXML
    private Label systemStock;
    @FXML
    private StackPane extraInfoStackPane;
    @FXML
    private VBox vboxExtrainfo;
    @FXML
    private AnchorPane extraInfoAnchorPane;
    @FXML
    private TextField systemNameEdit;
    @FXML
    private Label systemRealPrice;
    @FXML
    private Spinner<Integer> systemCounter;
    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
        componentControllers = new ArrayList();
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
        }else{
            root.getChildren().add(extraInfoStackPane);
            root.setPrefHeight(toogleHeight);
            root.setMaxHeight(toogleHeight);
        }
        shown = !shown;
    }
    
    @FXML
    private void saveSystemEdits(ActionEvent event) {
        String updateStatement = "UPDATE computersystem " +
        "SET name=? " +
        "WHERE componentlistid = " + systemId.getText() + ";";
        try {
            PreparedStatement preparedStatementInsert = databaseController.getCon().prepareStatement(updateStatement);
            preparedStatementInsert.setString(1, systemNameEdit.getText());
            preparedStatementInsert.executeUpdate();
            systemName.setText(systemNameEdit.getText());
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void setComponents(){
        int counter = 1;
        try {
            Connection con = databaseController.getCon();
            Statement componentListStatement = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            
            String componentListSql = "SELECT  " +
                                    "component.componentId, " +
                                    "component.name, " +
                                    "component.kind, " +
                                    "component.price, " +
                                    "component.preferedrestock, " +
                                    "component.minimumrestock, " +
                                    "component.stock, " +
                                    "cpu.socket, " +
                                    "cpu.clockspeed, " +
                                    "ram.ramtype, " +
                                    "ram.busspeed, " +
                                    "mainboard.socket as mainboardSocket, " +
                                    "mainboard.ramtype as mainboardRamType, " +
                                    "mainboard.onboardgraphics, " +
                                    "mainboard.formfactor as mainboardFormFactor, " +
                                    "computercase.formfactor " +
                                    "FROM computersystemcomponents " +
                                    "LEFT JOIN component ON component.componentId = computersystemcomponents.componentId " +
                                    "LEFT JOIN cpu ON cpu.componentId = component.componentId " +
                                    "LEFT JOIN ram ON ram.componentId = component.componentId " +
                                    "LEFT JOIN mainboard ON mainboard.componentId = component.componentId " +
                                    "LEFT JOIN computercase ON computercase.componentId = component.componentId " +
                                    "WHERE computersystemcomponents.componentListId = " + systemId.getText() +
                                    "ORDER BY component.componentId ASC;";
            
            ResultSet componentsRS = componentListStatement.executeQuery(componentListSql);
            while(componentsRS.next()){
                FXMLLoader loader = new FXMLLoader(getClass().getResource("fxml/Component.fxml"));
                AnchorPane pane = (AnchorPane)loader.load();
                pane.setOnMouseEntered(new EventHandler<MouseEvent>(){
                    @Override
                    public void handle(MouseEvent event) {
                        pane.setStyle("-fx-background-color:#848484;");
                    }
                
                });
                pane.setOnMouseExited(new EventHandler<MouseEvent>(){
                    @Override
                    public void handle(MouseEvent event) {
                        pane.setStyle("-fx-background-color:transparent;");
                    }
                });
                
                pane.setBorder(new Border(new BorderStroke(Color.BROWN, BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
                ComponentController controller = loader.<ComponentController>getController();
                componentControllers.add(controller);
                controller.setParentRoot(root);
                controller.setParentController(this);
                controller.setRootController(rootController);
                controller.setDatabaseController(databaseController);
                controller.setComponentId(componentsRS.getString("componentId"));
                controller.setComponentName(componentsRS.getString("name"));
                controller.setComponentKind(componentsRS.getString("kind"));
                controller.setComponentPrice("" + (((int)Math.round(componentsRS.getDouble("price")*1.3))-0.01));
                controller.setComponentRealPrice("" + componentsRS.getString("price"));
                totalPrice += componentsRS.getFloat("price");
                controller.setComponentStock(componentsRS.getString("stock"));
                if(minInventory > componentsRS.getInt("stock")){
                    minInventory = componentsRS.getInt("stock");
                }
                controller.setComponentPreferedStock(componentsRS.getString("preferedrestock"));
                controller.setComponentMinimumStock(componentsRS.getString("minimumrestock"));
                switch(componentsRS.getString("kind")){
                    case "CASE":
                        Case componentCase = new Case();
                        componentCase.setFormFactor(componentsRS.getString("formfactor") == null ? "Nothing" : componentsRS.getString("formfactor"));
                        controller.setComponent(componentCase);
                        controller.setComponentType(ComponentController.ComponentType.CASE);
                        break;
                    case "CPU":
                        Cpu componentCpu = new Cpu();
                        componentCpu.setClockSpeed(componentsRS.getFloat("clockSpeed"));
                        componentCpu.setSocket(componentsRS.getString("socket") == null ? "Nothing" : componentsRS.getString("socket"));
                        controller.setComponent(componentCpu);
                        controller.setComponentType(ComponentController.ComponentType.CPU);
                        break;
                    case "MAINBOARD":
                        Mainboard componentMainboard = new Mainboard();
                        componentMainboard.setSocket(componentsRS.getString("mainboardSocket") == null ? "Nothing" : componentsRS.getString("mainboardSocket"));
                        componentMainboard.setOnBoardGraphics(componentsRS.getBoolean("onboardgraphics"));
                        componentMainboard.setRamType(componentsRS.getString("mainboardRamType") == null ? "Nothing" : componentsRS.getString("mainboardRamType"));
                        componentMainboard.setFormFactor(componentsRS.getString("mainboardFormFactor") == null ? "Nothing" : componentsRS.getString("mainboardFormFactor"));
                        controller.setComponent(componentMainboard);
                        controller.setComponentType(ComponentController.ComponentType.MAINBOARD);
                        break;
                    case "RAM":
                        Ram componentRam = new Ram();
                        componentRam.setBusSpeed(componentsRS.getInt("busspeed"));
                        componentRam.setRamType(componentsRS.getString("ramtype") == null ? "Nothing" : componentsRS.getString("ramtype"));
                        controller.setComponent(componentRam);
                        controller.setComponentType(ComponentController.ComponentType.RAM);
                        break;
                }
                toogleHeight += 39;
                counter++;
                vboxExtrainfo.getChildren().add(pane);
                
            }
            setTotalPrice();
            setMinStock();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
    
    public void setTotalPrice(){
        systemPrice.setText("" + FXMLDocumentController.round(totalPrice, 2));
    }
    
    public void setMinStock(){
        systemStock.setText("" + minInventory);
        systemCounter.setValueFactory(new SpinnerValueFactory.IntegerSpinnerValueFactory(0, minInventory, 0));
    }
    /**
     * @param databaseController the databaseController to set
     */
    public void setDatabaseController(DatabaseController databaseController) {
        this.databaseController = databaseController;
    }
    
    /**
     * @param systemId the systemId to set
     */
    public void setSystemId(String systemId) {
        this.systemId.setText(systemId);
    }

    /**
     * @param systemName the systemName to set
     */
    public void setSystemName(String systemName) {
        this.systemName.setText(systemName);
        this.systemNameEdit.setText(systemName);
    }

    /**
     * @return the toogleHeight
     */
    public int getToogleHeight() {
        return toogleHeight;
    }

    /**
     * @param toogleHeight the toogleHeight to set
     */
    public void setToogleHeight(int toogleHeight) {
        this.toogleHeight = toogleHeight;
    }

    /**
     * @return the totalPrice
     */
    public double getTotalPrice() {
        return totalPrice;
    }

    /**
     * @param totalPrice the totalPrice to set
     */
    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @FXML
    private void buySystem(ActionEvent event) {
        for(int i = 0; i < systemCounter.getValue(); i++){
            if(Integer.parseInt(systemStock.getText()) != 0){
                for(ComponentController controller: componentControllers){
                    controller.buyComponent();
                }
            }
        }
        systemCounter.setValueFactory(new SpinnerValueFactory.IntegerSpinnerValueFactory(0, Integer.parseInt(systemStock.getText()), 0));
        rootController.initSystemList();
        rootController.setUpdateRestockingList(true);
        rootController.setUpdateComponentsList(true);
    }

    /**
     * @return the minInventory
     */
    public int getMinInventory() {
        return minInventory;
    }

    /**
     * @param minInventory the minInventory to set
     */
    public void setMinInventory(int minInventory) {
        this.minInventory = minInventory;
    }

    /**
     * @return the systemStock
     */
    public Label getSystemStock() {
        return systemStock;
    }

    /**
     * @param rootController the rootController to set
     */
    public void setRootController(FXMLDocumentController rootController) {
        this.rootController = rootController;
    }
    
}
