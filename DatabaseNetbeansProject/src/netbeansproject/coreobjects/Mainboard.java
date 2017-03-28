/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package netbeansproject.coreobjects;

/**
 *
 * @author Lagoni
 */
public class Mainboard extends Component{
    private String socket;
    private String ramType;
    private boolean onBoardGraphics;
    private String formFactor;

    /**
     * @return the socket
     */
    public String getSocket() {
        return socket;
    }

    /**
     * @param socket the socket to set
     */
    public void setSocket(String socket) {
        this.socket = socket;
    }

    /**
     * @return the ramType
     */
    public String getRamType() {
        return ramType;
    }

    /**
     * @param ramType the ramType to set
     */
    public void setRamType(String ramType) {
        this.ramType = ramType;
    }

    /**
     * @return the onBoardGraphics
     */
    public boolean isOnBoardGraphics() {
        return onBoardGraphics;
    }

    /**
     * @param onBoardGraphics the onBoardGraphics to set
     */
    public void setOnBoardGraphics(boolean onBoardGraphics) {
        this.onBoardGraphics = onBoardGraphics;
    }

    /**
     * @return the formFactor
     */
    public String getFormFactor() {
        return formFactor;
    }

    /**
     * @param formFactor the formFactor to set
     */
    public void setFormFactor(String formFactor) {
        this.formFactor = formFactor;
    }
}
