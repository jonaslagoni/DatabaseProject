/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package netbeansproject;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.Event;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.control.ListView;
import javafx.scene.control.TextField;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.Border;
import javafx.scene.layout.BorderStroke;
import javafx.scene.layout.BorderStrokeStyle;
import javafx.scene.layout.BorderWidths;
import javafx.scene.layout.CornerRadii;
import javafx.scene.paint.Color;
import netbeansproject.coreobjects.Case;
import netbeansproject.coreobjects.Cpu;
import netbeansproject.coreobjects.Mainboard;
import netbeansproject.coreobjects.Ram;
import netbeansproject.databasecore.DatabaseController;
import netbeansproject.testdata.TestDataController;

/**
 *
 * @author Lagoni
 */
public class FXMLDocumentController implements Initializable {
    private TestDataController testDataController;
    private DatabaseController databaseController;
    private ObservableList<AnchorPane> components = FXCollections.observableArrayList();
    private ObservableList<AnchorPane> systems = FXCollections.observableArrayList();
    private ObservableList<AnchorPane> restocking = FXCollections.observableArrayList();
    private boolean updateComponentsList = false;
    private boolean updateSystemList = false;
    private boolean updateRestockingList = false;
    
    @FXML
    private ListView<AnchorPane> componentList;
    @FXML
    private TextField numberOfComponents;
    @FXML
    private TextField numberOfSystems;
    @FXML
    private TextField prefixCpu;
    @FXML
    private TextField prefixRam;
    @FXML
    private TextField prefixMainboard;
    @FXML
    private TextField prefixGpu;
    @FXML
    private TextField prefixCase;
    @FXML
    private TextField prefixSystem;
    @FXML
    private TextField databaseUrl;
    @FXML
    private TextField databasePort;
    @FXML
    private TextField databaseUsername;
    @FXML
    private TextField databasePassword;
    @FXML
    private TextField databaseDatabase;
    @FXML
    private ListView<AnchorPane> SystemList;
    @FXML
    private ListView<AnchorPane> restockingList;
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
        databaseController = new DatabaseController();
        testDataController = new TestDataController(databaseController);
        componentList.setItems(components);
        SystemList.setItems(systems);
        restockingList.setItems(restocking);
        initDBAttributes();
        if(databaseController.makeConnection()){
            initSystemList();
            initComponentList();
            initRestockingList();
        }
    }    
    
    private void initDBAttributes(){
        databaseUrl.setText(databaseController.getUrl());
        databasePort.setText(databaseController.getPort());
        databaseUsername.setText(databaseController.getUsername());
        databasePassword.setText(databaseController.getPassword());
        databaseDatabase.setText(databaseController.getDatabase());
    }
    
    public void initRestockingList(){
        restocking.clear();
        try {
            Connection con = databaseController.getCon();
            Statement componentListStatement = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            
            String restockingListSQL = "SELECT  " +
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
                                    "FROM component " +
                                    "LEFT JOIN cpu ON cpu.componentId = component.componentId " +
                                    "LEFT JOIN ram ON ram.componentId = component.componentId " +
                                    "LEFT JOIN mainboard ON mainboard.componentId = component.componentId " +
                                    "LEFT JOIN computercase ON computercase.componentId = component.componentId " +
                                    "WHERE component.stock < component.minimumrestock " +
                                    "ORDER BY component.componentId ASC;";
            
            ResultSet componentsRS = componentListStatement.executeQuery(restockingListSQL);
            while(componentsRS.next()){
                FXMLLoader loader = new FXMLLoader(getClass().getResource("fxml/Component.fxml"));
                AnchorPane pane = (AnchorPane)loader.load();
                ComponentController controller = loader.<ComponentController>getController();
                controller.setDatabaseController(databaseController);
                controller.setRootController(this);
                controller.setComponentId(componentsRS.getString("componentId"));
                controller.setComponentName(componentsRS.getString("name"));
                controller.setComponentKind(componentsRS.getString("kind"));
                controller.setComponentPrice(componentsRS.getString("price"));
                controller.setComponentStock(componentsRS.getString("stock"));
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
                restocking.add(pane);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
    
    public void initSystemList(){
        systems.clear();
        try {
            Connection con = databaseController.getCon();
            Statement componentListStatement = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            
            String systemListSql = "SELECT " +
                                    "computersystem.componentListId, " + 
                                    "computersystem.name " +
                                    "FROM computersystem " +
                                    "ORDER BY computersystem.componentListId ASC;";
            
            ResultSet systemRS = componentListStatement.executeQuery(systemListSql);
            while(systemRS.next()){
                FXMLLoader loader = new FXMLLoader(getClass().getResource("fxml/System.fxml"));
                AnchorPane pane = (AnchorPane)loader.load();
                pane.setBorder(new Border(new BorderStroke(Color.BLACK, BorderStrokeStyle.SOLID, CornerRadii.EMPTY, BorderWidths.DEFAULT)));
                SystemController controller = loader.<SystemController>getController();
                controller.setRootController(this);
                controller.setDatabaseController(databaseController);
                controller.setSystemId(systemRS.getString("componentListId"));
                controller.setSystemName(systemRS.getString("name"));
                controller.setComponents();
                systems.add(pane);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
    
    public void initComponentList(){
        components.clear();
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
                                    "FROM component " +
                                    "LEFT JOIN cpu ON cpu.componentId = component.componentId " +
                                    "LEFT JOIN ram ON ram.componentId = component.componentId " +
                                    "LEFT JOIN mainboard ON mainboard.componentId = component.componentId " +
                                    "LEFT JOIN computercase ON computercase.componentId = component.componentId " +
                                    "ORDER BY component.componentId ASC;";
            
            ResultSet componentsRS = componentListStatement.executeQuery(componentListSql);
            while(componentsRS.next()){
                FXMLLoader loader = new FXMLLoader(getClass().getResource("fxml/Component.fxml"));
                AnchorPane pane = (AnchorPane)loader.load();
                ComponentController controller = loader.<ComponentController>getController();
                controller.setDatabaseController(databaseController);
                controller.setRootController(this);
                controller.setComponentId(componentsRS.getString("componentId"));
                controller.setComponentName(componentsRS.getString("name"));
                controller.setComponentKind(componentsRS.getString("kind"));
                controller.setComponentPrice("" + (((((int)Math.round(componentsRS.getDouble("price")*1.3))+99) / 100)*100-1));
                controller.setComponentRealPrice("" + componentsRS.getString("price"));
                controller.setComponentStock(componentsRS.getString("stock"));
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
                components.add(pane);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
    @FXML
    private void updateComponentsList(ActionEvent event) {
        if(databaseController.isConnected()){
            initComponentList();
        }
    }

    @FXML
    private void applyNewData(ActionEvent event) {
        if(databaseController.isConnected()){
            if(isInteger(numberOfComponents.getText(), 10)){
                testDataController.setNumberOfComponents(Integer.parseInt(numberOfComponents.getText()));
            }else{
                numberOfComponents.setText("" + testDataController.getNumberOfComponents());
            }
            if(isInteger(numberOfSystems.getText(), 10)){
                testDataController.setNumberOfSystems(Integer.parseInt(numberOfSystems.getText()));
            }else{
                numberOfSystems.setText("" + testDataController.getNumberOfSystems());
            }
            testDataController.setPrefixCase(prefixCase.getText());
            testDataController.setPrefixCpu(prefixCpu.getText());
            testDataController.setPrefixGpu(prefixGpu.getText());
            testDataController.setPrefixMainboard(prefixMainboard.getText());
            testDataController.setPrefixRam(prefixRam.getText());
            testDataController.setPrefixSystem(prefixSystem.getText());

            testDataController.deleteExistingTuples();
            testDataController.insertTestData();
            updateComponentsList = true;
            updateSystemList = true;
            updateRestockingList = true;
        }
    }

    @FXML
    private void saveDatabaseSettings(ActionEvent event) {
        databaseController.setUrl(databaseUrl.getText());
        databaseController.setPort(databasePort.getText());
        databaseController.setUsername(databaseUsername.getText());
        databaseController.setPassword(databasePassword.getText());
        databaseController.setDatabase(databaseDatabase.getText());
        if(databaseController.makeConnection()){
            initSystemList();
            initComponentList();
            initRestockingList();
        }
    }
    public static boolean isDouble(String s, int precisionLast, int precisionFirst){
        String[] splittedString = s.split("\\.");
        if(splittedString.length < 2){
            if(splittedString.length == 1){
                if(isInteger(splittedString[0], 10)){
                    return true;
                }
            }
            return false;
        }
        if(!isInteger(splittedString[0], 10) || !isInteger(splittedString[1], 10)){
            return false;
        }
        if(splittedString[0].length() > precisionFirst || splittedString[1].length() > precisionLast){
            return false;
        }
        return true;
    }
    public static boolean isInteger(String s, int radix) {
        if(s.isEmpty()) return false;
        for(int i = 0; i < s.length(); i++) {
            if(i == 0 && s.charAt(i) == '-') {
                if(s.length() == 1) return false;
                else continue;
            }
            if(Character.digit(s.charAt(i),radix) < 0) return false;
        }
        return true;
    }
    public static double round(double value, int places) {
        if (places < 0) throw new IllegalArgumentException();

        BigDecimal bd = new BigDecimal(value);
        bd = bd.setScale(places, RoundingMode.HALF_UP);
        return bd.doubleValue();
    }

    @FXML
    private void updateSystemList(ActionEvent event) {
        if(databaseController.isConnected()){
            initSystemList();
        }
    }

    @FXML
    private void updateRestockList(ActionEvent event) {
        if(databaseController.isConnected()){
            initRestockingList();
        }
    }

    @FXML
    private void restockComponents(ActionEvent event) {
        
        if(databaseController.isConnected()){
            String updateStatement = "UPDATE component " +
            "SET stock = preferedrestock " +
            "WHERE stock < minimumrestock;";
            try {
                PreparedStatement preparedStatementInsert = databaseController.getCon().prepareStatement(updateStatement, Statement.RETURN_GENERATED_KEYS);
                preparedStatementInsert.executeUpdate();
                initRestockingList();
                updateComponentsList = true;
                updateSystemList = true;
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
    @FXML
    private void shouldUpdateComponenets(Event event) {
        if(updateComponentsList){
            initComponentList();
            updateComponentsList = false;
        }
    }

    @FXML
    private void shouldUpdateSystems(Event event) {
        if(updateSystemList){
            initSystemList();
            updateSystemList = false;
        }
    }

    @FXML
    private void shouldUpdateRestockingList(Event event) {
        if(updateRestockingList){
            initRestockingList();
            updateRestockingList = false;
        }
    }

    /**
     * @param updateComponentsList the updateComponentsList to set
     */
    public void setUpdateComponentsList(boolean updateComponentsList) {
        this.updateComponentsList = updateComponentsList;
    }

    /**
     * @param updateSystemList the updateSystemList to set
     */
    public void setUpdateSystemList(boolean updateSystemList) {
        this.updateSystemList = updateSystemList;
    }

    /**
     * @param updateRestockingList the updateRestockingList to set
     */
    public void setUpdateRestockingList(boolean updateRestockingList) {
        this.updateRestockingList = updateRestockingList;
    }
}
