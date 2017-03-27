/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package netbeansproject;

import java.io.IOException;
import java.net.URL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.TextField;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.Pane;
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
    
    
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
        databaseController = new DatabaseController();
        databaseController.makeConnection();
        testDataController = new TestDataController(databaseController);
        componentList.setItems(components);
        initComponentList();
    }    
    private void initComponentList(){
        try {
            Connection con = databaseController.getCon();
            Statement componentListStatement = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            
            String componentListSql = "SELECT * FROM component " +
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
                controller.setComponentId(componentsRS.getString("componentId"));
                controller.setComponentName(componentsRS.getString("name"));
                controller.setComponentKind(componentsRS.getString("kind"));
                controller.setComponentPrice(componentsRS.getString("price"));
                controller.setComponentStock(componentsRS.getString("stock"));
                controller.setComponentPreferedStock(componentsRS.getString("preferedrestock"));
                controller.setComponentMinimumStock(componentsRS.getString("minimumrestock"));
                switch(componentsRS.getString("kind")){
                    case "CASE":
                        
                        break;
                    case "CPU":
                        
                        break;
                    case "MAINBOARD":
                        
                        break;
                    case "RAM":
                        
                        break;
                }
                components.add(pane);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        } catch (IOException ex) {
            System.out.println(ex);
        }
    }
    @FXML
    private void updateComponentsList(ActionEvent event) {
    }

    @FXML
    private void applyNewData(ActionEvent event) {
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
    }

    @FXML
    private void saveDatabaseSettings(ActionEvent event) {
        
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
}
