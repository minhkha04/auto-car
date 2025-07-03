/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.BestUsedPartDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import mylib.DBUtils;

/**
 *
 * @author lengu
 */
public class PartUsedDAO {

    public List<BestUsedPartDTO> getBestUsedPartDTOs() {
        String query = "  SELECT TOP 1 WITH TIES \n"
                + "       p.partName AS 'name', \n"
                + "       SUM(pu.numberUsed) AS 'quantity',\n"
                + "       p.retailPrice *  SUM(pu.numberUsed) AS 'totalRevenue'\n"
                + "FROM [dbo].[PartsUsed] AS pu\n"
                + "INNER JOIN [dbo].[Parts] AS p ON p.partID = pu.partID\n"
                + "GROUP BY p.partName, p.retailPrice\n"
                + "ORDER BY SUM(pu.numberUsed) DESC;";
        Connection connection = null;
        List<BestUsedPartDTO> result = new ArrayList<>();

        try {
            connection = DBUtils.getConnection();
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(query);

                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    String name = resultSet.getString("name");
                    int quantity = resultSet.getInt("quantity");
                    double revenue = resultSet.getDouble("totalRevenue");
                    
                    BestUsedPartDTO bestUsedPartDTO = new BestUsedPartDTO(name, quantity, revenue);
                    result.add(bestUsedPartDTO);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
