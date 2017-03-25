/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package netbeansproject.testdata;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import netbeansproject.databasecore.DatabaseController;

/**
 *
 * @author Lagoni
 */
public class TestDataController {
    private List<String> allCpuSockets;
    private List<String> allFormFactors;
    private List<String> allRamTypes;
    private HashMap<String, List<Integer>> cpuSocketList;
    private HashMap<String, List<Integer>> formFactorList;
    private HashMap<String, List<Integer>> ramTypeList;
    private List<Integer> gpuList;
    private final DatabaseController databaseController;
    private final int maxPreferedRestock = 50;
    private final int minPreferedRestock = 10;
    private final int maxMinimumRestock = minPreferedRestock-1;
    private final int minMinimumRestock = 2;
    private final float maxPrice = 10000.0f;
    private final float minPrice = 1.0f;
    
    //cpu
    private final float maxBusSpeedCpu = 4.5f;
    private final float minBusSpeedCpu = 2.0f;
    
    //RAM
    private final int maxBusSpeedRam = 3500;
    private final int minBusSpeedRam = 1024;
    
    private final String insertComponent = "INSERT INTO component(name, kind, price, preferedrestock, minimumrestock, stock) VALUES (?, ?, ?, ?, ?, ?);";
    private final String insertCPU = "INSERT INTO cpu(componentId, socket, busspeed) VALUES (?, ?, ?);";
    private final String insertRAM = "INSERT INTO ram(componentid, ramtype, busspeed) VALUES (?, ?, ?);";
    private final String insertComputerCase = "INSERT INTO computercase(componentid, formfactor) VALUES (?, ?);";
    private final String insertMainboards = "INSERT INTO mainboard(componentid, socket, ramtype, onboardgraphics, formfactor) VALUES (?, ?, ?, ?, ?);";
    private final String insertComputerSystem = "INSERT INTO computersystem(name) VALUES (?);";
    private final String insertComputerSystemComponent = "INSERT INTO computersystemcomponents(componentid, componentlistid) VALUES (?, ?);";
    
    private final Random random;
    
    public TestDataController(){
        databaseController = new DatabaseController();
        random = new Random();
        
        allCpuSockets = new ArrayList(){{
            add("LGA1151 Socket");
            add("LGA1150 Socket");
            add("LGA2011-v3 Socket");
        }};
        allFormFactors = new ArrayList(){{
            add("ATX");
            add("EATX");
            add("microATX");
        }};
        allRamTypes = new ArrayList(){{
            add("DDR2");
            add("DDR3");
            add("DDR4");
        }};
        
        cpuSocketList = new HashMap();
        formFactorList = new HashMap();
        ramTypeList = new HashMap();
        gpuList = new ArrayList();
    }
    
    public void deleteExistingTuples(){
        Connection connection = databaseController.getCon();
        String deleteComponent = "DELETE FROM component;";
        String deleteComputerSystem = "DELETE FROM computersystem;";
        String alterComponentAutoIncrement = "ALTER SEQUENCE component_componentid_seq RESTART WITH 1;";
        String alterSystemAutoIncrement = "ALTER SEQUENCE computersystem_componentlistid_seq RESTART WITH 1;";
        try {
            Statement stmt = connection.createStatement();
            connection.setAutoCommit(false);
            stmt.executeUpdate(deleteComponent);
            stmt.executeUpdate(deleteComputerSystem);
            stmt.executeUpdate(alterComponentAutoIncrement);
            stmt.executeUpdate(alterSystemAutoIncrement);
            connection.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
    
    public void insertTestData(int numberOfComponents, int numberOfSystems){
        Connection connection = databaseController.getCon();
        try {
            connection.setAutoCommit(false);
            insertCPUs(connection, numberOfComponents);
            insertRAMs(connection, numberOfComponents);
            insertComputerCases(connection, numberOfComponents);
            insertGPUs(connection, numberOfComponents);
            insertMainboards(connection, numberOfComponents);
            connection.commit();
            insertPredefinedSystems(connection, numberOfSystems, numberOfComponents);
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
    
    private void insertCPUs(Connection connection, int numberOfComponents) throws SQLException{
        for(int i = 1; i <= numberOfComponents; i++){
            insertCPU(connection,
                "CPU " + i, //name
                allCpuSockets.get(random.nextInt(allCpuSockets.size())));
        }
    }
    
    private void insertRAMs(Connection connection, int numberOfComponents) throws SQLException{
        for(int i = 1; i <= numberOfComponents; i++){
            insertRAM(connection,
                "RAM " + i, //name
                allRamTypes.get(random.nextInt(allRamTypes.size())));
        }
    }
    
    private void insertComputerCases(Connection connection, int numberOfComponents) throws SQLException{
        for(int i = 1; i <= numberOfComponents; i++){
            insertComputerCase(connection,
                "Computercase " + i, //name
                allFormFactors.get(random.nextInt(allFormFactors.size())));
        }
    }
    
    private void insertGPUs(Connection connection, int numberOfComponents) throws SQLException{
        for(int i = 1; i <= numberOfComponents; i++){
            insertGPU(connection, "GPU " + i);
        }
    }
    
    private void insertMainboards(Connection connection, int numberOfComponents) throws SQLException{
        for(int i = 1; i <= numberOfComponents; i++){
            insertMainBoard(connection, "Mainboard " + i, (i % 2 == 0));
        }
    }
    
    private void insertPredefinedSystems(Connection connection, int numberOfSystems, int numberOfComponents) throws SQLException{
        for(int i = 1; i <= numberOfSystems; i++){
            insertPredefinedSystem(connection, "Pre defined system " + i, numberOfComponents);
        }
    }
    
    private void insertCPU(Connection connection, String name, String socket) throws SQLException {
        PreparedStatement preparedStatementInsert = connection.prepareStatement(insertComponent, Statement.RETURN_GENERATED_KEYS);
        preparedStatementInsert.setString(1, name); 
        preparedStatementInsert.setString(2, "CPU");
        preparedStatementInsert.setFloat(3, (float)(Math.round((random.nextFloat()* (maxPrice - minPrice) + minPrice)*100.0)/100.0));
        preparedStatementInsert.setInt(4, random.nextInt(maxPreferedRestock - minPreferedRestock) + minPreferedRestock);
        preparedStatementInsert.setInt(5, random.nextInt(maxMinimumRestock - minMinimumRestock) + minMinimumRestock);
        preparedStatementInsert.setInt(6, random.nextInt(maxPreferedRestock - minMinimumRestock) + minMinimumRestock);
        preparedStatementInsert.executeUpdate();
        ResultSet generatedKeys = preparedStatementInsert.getGeneratedKeys();
        generatedKeys.next();
        final int lastInsertedId = generatedKeys.getInt(1);
        preparedStatementInsert = connection.prepareStatement(insertCPU);
        preparedStatementInsert.setInt(1, lastInsertedId);
        preparedStatementInsert.setString(2, socket);
        preparedStatementInsert.setFloat(3, (float)(Math.round((random.nextFloat()* (maxBusSpeedCpu - minBusSpeedCpu) + minBusSpeedCpu)*10.0)/10.0));
        preparedStatementInsert.executeUpdate();
        if(cpuSocketList.get(socket) == null){
            cpuSocketList.put(socket, new ArrayList(){{add(lastInsertedId);}});
        }else{
            cpuSocketList.get(socket).add(lastInsertedId);
        }
    } 
    
    private void insertRAM(Connection connection, String name, String ramtype) throws SQLException{
        PreparedStatement preparedStatementInsert = connection.prepareStatement(insertComponent, Statement.RETURN_GENERATED_KEYS);
        preparedStatementInsert.setString(1, name); 
        preparedStatementInsert.setString(2, "RAM");
        preparedStatementInsert.setFloat(3, (float)(Math.round((random.nextFloat()* (maxPrice - minPrice) + minPrice)*100.0)/100.0));
        preparedStatementInsert.setInt(4, random.nextInt(maxPreferedRestock - minPreferedRestock) + minPreferedRestock);
        preparedStatementInsert.setInt(5, random.nextInt(maxMinimumRestock - minMinimumRestock) + minMinimumRestock);
        preparedStatementInsert.setInt(6, random.nextInt(maxPreferedRestock - minMinimumRestock) + minMinimumRestock);
        preparedStatementInsert.executeUpdate();
        ResultSet generatedKeys = preparedStatementInsert.getGeneratedKeys();
        generatedKeys.next();
        final int lastInsertedId = generatedKeys.getInt(1);
        preparedStatementInsert = connection.prepareStatement(insertRAM);
        preparedStatementInsert.setInt(1, lastInsertedId);
        preparedStatementInsert.setString(2, ramtype);
        preparedStatementInsert.setInt(3, random.nextInt(maxBusSpeedRam - minBusSpeedRam) + minBusSpeedRam);
        preparedStatementInsert.executeUpdate();
        if(ramTypeList.get(ramtype) == null){
            ramTypeList.put(ramtype, new ArrayList(){{add(lastInsertedId);}});
        }else{
            ramTypeList.get(ramtype).add(lastInsertedId);
        }
    }
    
    private void insertComputerCase(Connection connection, String name, String formFactor) throws SQLException{
        PreparedStatement preparedStatementInsert = connection.prepareStatement(insertComponent, Statement.RETURN_GENERATED_KEYS);
        preparedStatementInsert.setString(1, name); 
        preparedStatementInsert.setString(2, "CASE");
        preparedStatementInsert.setFloat(3, (float)(Math.round((random.nextFloat()* (maxPrice - minPrice) + minPrice)*100.0)/100.0));
        preparedStatementInsert.setInt(4, random.nextInt(maxPreferedRestock - minPreferedRestock) + minPreferedRestock);
        preparedStatementInsert.setInt(5, random.nextInt(maxMinimumRestock - minMinimumRestock) + minMinimumRestock);
        preparedStatementInsert.setInt(6, random.nextInt(maxPreferedRestock - minMinimumRestock) + minMinimumRestock);
        preparedStatementInsert.executeUpdate();
        ResultSet generatedKeys = preparedStatementInsert.getGeneratedKeys();
        generatedKeys.next();
        final int lastInsertedId = generatedKeys.getInt(1);
        preparedStatementInsert = connection.prepareStatement(insertComputerCase);
        preparedStatementInsert.setInt(1, lastInsertedId);
        preparedStatementInsert.setString(2, formFactor);
        preparedStatementInsert.executeUpdate(); 
        if(formFactorList.get(formFactor) == null){
            formFactorList.put(formFactor, new ArrayList(){{add(lastInsertedId);}});
        }else{
            formFactorList.get(formFactor).add(lastInsertedId);
        }
        
    }
    
    private void insertGPU(Connection connection, String name) throws SQLException{
        PreparedStatement preparedStatementInsert = connection.prepareStatement(insertComponent, Statement.RETURN_GENERATED_KEYS);
        preparedStatementInsert.setString(1, name); 
        preparedStatementInsert.setString(2, "GPU");
        preparedStatementInsert.setFloat(3, (float)(Math.round((random.nextFloat()* (maxPrice - minPrice) + minPrice)*100.0)/100.0));
        preparedStatementInsert.setInt(4, random.nextInt(maxPreferedRestock - minPreferedRestock) + minPreferedRestock);
        preparedStatementInsert.setInt(5, random.nextInt(maxMinimumRestock - minMinimumRestock) + minMinimumRestock);
        preparedStatementInsert.setInt(6, random.nextInt(maxPreferedRestock - minMinimumRestock) + minMinimumRestock);
        preparedStatementInsert.executeUpdate();
        ResultSet generatedKeys = preparedStatementInsert.getGeneratedKeys();
        generatedKeys.next();
        final int lastInsertedId = generatedKeys.getInt(1);
        gpuList.add(lastInsertedId);
    }
    
    private void insertMainBoard(Connection connection, String name, boolean onBoardGraphics) throws SQLException{
        PreparedStatement preparedStatementInsert = connection.prepareStatement(insertComponent, Statement.RETURN_GENERATED_KEYS);
        int lastInsertedId = 0;
        preparedStatementInsert.setString(1, name); 
        preparedStatementInsert.setString(2, "MAINBOARD");
        preparedStatementInsert.setFloat(3, (float)(Math.round((random.nextFloat()* (maxPrice - minPrice) + minPrice)*100.0)/100.0));
        preparedStatementInsert.setInt(4, random.nextInt(maxPreferedRestock - minPreferedRestock) + minPreferedRestock);
        preparedStatementInsert.setInt(5, random.nextInt(maxMinimumRestock - minMinimumRestock) + minMinimumRestock);
        preparedStatementInsert.setInt(6, random.nextInt(maxPreferedRestock - minMinimumRestock) + minMinimumRestock);
        preparedStatementInsert.executeUpdate();
        ResultSet generatedKeys = preparedStatementInsert.getGeneratedKeys();
        if (generatedKeys.next()) {
            lastInsertedId = generatedKeys.getInt(1);
        }else{
            throw new SQLException("NO KEYS FOUND");
        }
        
        preparedStatementInsert = connection.prepareStatement(insertMainboards);
        preparedStatementInsert.setInt(1, lastInsertedId);
        String cpuSocket;
        do{
            cpuSocket = allCpuSockets.get(random.nextInt(allCpuSockets.size()));
        }while(cpuSocketList.get(cpuSocket) == null);
        preparedStatementInsert.setString(2, cpuSocket); //socket
        String ramType;
        do{
            ramType = allRamTypes.get(random.nextInt(allRamTypes.size()));
        }while(ramTypeList.get(ramType) == null);
        preparedStatementInsert.setString(3, ramType); //ramtype
        preparedStatementInsert.setBoolean(4, onBoardGraphics); //onboardgraphics
        String formFactor;
        do{
            formFactor = allFormFactors.get(random.nextInt(allFormFactors.size()));
        }while(formFactorList.get(formFactor) == null);
        preparedStatementInsert.setString(5, formFactor); //formFactor
        preparedStatementInsert.executeUpdate();
    }

    private void insertPredefinedSystem(Connection connection, String name, int numberOfComponents) throws SQLException{
        Statement mainboardStatement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        String mainboardSQL = "SELECT * FROM mainboard";
        ResultSet mainboardRS = mainboardStatement.executeQuery(mainboardSQL);
        mainboardRS.absolute(random.nextInt(numberOfComponents));
        //grab the mainboard id
        int mainboardId = mainboardRS.getInt("componentid");
        String socketToFind = mainboardRS.getString("socket");
        String ramTypeToFind = mainboardRS.getString("ramtype");
        String formFactorToFind = mainboardRS.getString("formfactor");
        boolean findGPU = mainboardRS.getBoolean("onboardgraphics");
        
        //get the cpu id
        int cpuId = cpuSocketList.get(socketToFind).get(random.nextInt(cpuSocketList.get(socketToFind).size()));
        
        //get the case id
        int caseId = formFactorList.get(formFactorToFind).get(random.nextInt(formFactorList.get(formFactorToFind).size()));
        
        //get the ram id
        int ramId = ramTypeList.get(ramTypeToFind).get(random.nextInt(ramTypeList.get(ramTypeToFind).size()));
        int gpuId = 0;
        if(findGPU){
            gpuId = gpuList.get(random.nextInt(gpuList.size()));
        }
        
        //insert the data
        connection.setAutoCommit(false);
        PreparedStatement preparedStatementInsert = connection.prepareStatement(insertComputerSystem, Statement.RETURN_GENERATED_KEYS);
        preparedStatementInsert.setString(1, name);
        preparedStatementInsert.executeUpdate();
        ResultSet generatedKeys = preparedStatementInsert.getGeneratedKeys();
        generatedKeys.next();
        final int lastInsertedId = generatedKeys.getInt(1);
        
        insertComponent(connection, preparedStatementInsert, mainboardId, lastInsertedId);
        insertComponent(connection, preparedStatementInsert, cpuId, lastInsertedId);
        insertComponent(connection, preparedStatementInsert, caseId, lastInsertedId);
        insertComponent(connection, preparedStatementInsert, ramId, lastInsertedId);
        if(findGPU){
            insertComponent(connection, preparedStatementInsert, gpuId, lastInsertedId);
        }
        connection.commit();
    }
    
    public void insertComponent(Connection connection, PreparedStatement preparedStatementInsert, int componentId, int systemId) throws SQLException{
        preparedStatementInsert = connection.prepareStatement(insertComputerSystemComponent);
        preparedStatementInsert.setInt(1, componentId);
        preparedStatementInsert.setInt(2, systemId);
        preparedStatementInsert.executeUpdate();
    }
}