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
public class Ram extends Component{
    private String ramType;
    private int busSpeed;

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
     * @return the busSpeed
     */
    public int getBusSpeed() {
        return busSpeed;
    }

    /**
     * @param busSpeed the busSpeed to set
     */
    public void setBusSpeed(int busSpeed) {
        this.busSpeed = busSpeed;
    }

}
