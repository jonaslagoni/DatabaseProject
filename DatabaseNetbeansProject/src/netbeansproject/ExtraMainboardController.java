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
public class ExtraMainboardController implements Initializable {
    @FXML
    private Label socket;
    @FXML
    private Label ramType;
    @FXML
    private Label onBoardGraphics;
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
     * @param socket the socket to set
     */
    public void setSocket(String socket) {
        this.socket.setText(socket);
    }

    /**
     * @param ramType the ramType to set
     */
    public void setRamType(String ramType) {
        this.ramType.setText(ramType);
    }

    /**
     * @param onBoardGraphics the onBoardGraphics to set
     */
    public void setOnBoardGraphics(String onBoardGraphics) {
        this.onBoardGraphics.setText(onBoardGraphics);
    }

    /**
     * @param formFactor the formFactor to set
     */
    public void setFormFactor(String formFactor) {
        this.formFactor.setText(formFactor);
    }

}
