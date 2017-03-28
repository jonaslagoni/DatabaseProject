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
public class Cpu extends Component{
    private String socket;
    private double clockSpeed;

    public Cpu(){
        socket = "Not listed";
        clockSpeed = 0.0;
    }

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
     * @return the clockSpeed
     */
    public double getClockSpeed() {
        return clockSpeed;
    }

    /**
     * @param clockSpeed the clockSpeed to set
     */
    public void setClockSpeed(double clockSpeed) {
        this.clockSpeed = clockSpeed;
    }
}
