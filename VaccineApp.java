import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import com.ibm.db2.cmx.PushDownError;
import javax.sound.midi.SysexMessage;
import java.sql.* ;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Scanner;

public class VaccineApp {

        public static int selectNum(){
            Scanner input = new Scanner(System.in);
            System.out.print("Please select the number: ");
            return input.nextInt();
        }

        public static boolean confirmation(){
            String option;
            Scanner input = new Scanner(System.in);
            System.out.print("Are you sure (yes/no)? ");
            option = input.nextLine();
            if(option.toLowerCase().equals("yes")){
                return true;
            }else{
                return false;
            }

        }
        //create
        public static int menu() {
            int option;
            Scanner input = new Scanner(System.in);

            System.out.println("VaccineApp Main Menu");
            System.out.println("      1. Add a Person");
            System.out.println("      2. Assign a slot to a Person");
            System.out.println("      3. Enter Vaccination information");
            System.out.println("      4. Exit Application");
            System.out.print("Please Enter Your Option:");

            option = input.nextInt();
            return option;
        }

        public static void main ( String [ ] args ) throws SQLException
        {
            // Unique table names.  Either the user supplies a unique identifier as a command line argument, or the program makes one up.
            String tableName = "";
            int sqlCode=0;      // Variable to hold SQLCODE
            String sqlState="00000";  // Variable to hold SQLSTATE

            if ( args.length > 0 )
                tableName += args [ 0 ] ;
            else
                tableName += "exampletbl";

            // Register the driver.  You must register the driver before you can use it.
            try { DriverManager.registerDriver ( new com.ibm.db2.jcc.DB2Driver() ) ; }
            catch (Exception cnfe){ System.out.println("Class not found"); }

            // This is the url you must use for DB2.
            //Note: This url may not valid now !
            String url = "jdbc:db2://winter2021-comp421.cs.mcgill.ca:50000/cs421";

            //REMEMBER to remove your user id and password before submitting your code!!
            String your_userid = "rter";
            String your_password = "london530873";
            //AS AN ALTERNATIVE, you can just set your password in the shell environment in the Unix (as shown below) and read it from there.
            //$  export SOCSPASSWD=yoursocspasswd
            if(your_userid == null && (your_userid = System.getenv("SOCSUSER")) == null)
            {
                System.err.println("Error!! do not have a password to connect to the database!");
                System.exit(1);
            }
            if(your_password == null && (your_password = System.getenv("SOCSPASSWD")) == null)
            {
                System.err.println("Error!! do not have a password to connect to the database!");
                System.exit(1);
            }
            Connection con = DriverManager.getConnection (url,your_userid,your_password) ;
            Statement statement = con.createStatement ( ) ;

            //choosing options
            int choice = menu();
            while(choice != 4){
                if(choice == 1){
                    try {
                        System.out.println("Adding a new person");
                        System.out.println("Please write this way: val1, val2,...");
                        System.out.print("Input: ");
                        //user input
                        Scanner input = new Scanner(System.in);
                        String to_insert = input.nextLine();

                        String[] infoslist = to_insert.split(",");

                        //check if person exists already in our database
                        String personExists = "SELECT count(pname) " +
                                "FROM person " +
                                "WHERE insNum=" + infoslist[0] + " ;";
                        java.sql.ResultSet rs = statement.executeQuery ( personExists );

                        int num = 0;
                        while(rs.next()){
                            num = rs.getInt(1);
                        }
                        if(num != 0) {
                            String delete = "DELETE FROM PERSON WHERE insNum = " + infoslist[0] + " ;";
                            statement.executeUpdate(delete);
                        }
                        String insertSQL = "INSERT INTO PERSON VALUES (" + to_insert + ") ;";

                        if(confirmation()) {
                            statement.executeUpdate(insertSQL);
                            System.out.println("Person successfully added\n");
                        }else{
                            System.out.println("Cancel adding person. Returning to main menu.\n");
                        }
                        //return to menu
                        choice = menu();
                    }catch (SQLException e){
                        //  System.out.println(e);

//                    String update = (3333,'Jane Koa',444444,'35907 Watsica Underpass Apt. 056 North Jarrett, NH 91134','1999-08-21','F','2020-04-01','Health Worker')
                        System.out.println("Person with this insurance number already exists.\n");
                    }
                }else if(choice == 2){
                    //query the number of doses that a person took
                    int insNum;
                    Scanner input = new Scanner(System.in);
                    System.out.print("To register a slot, please enter person's insurance number: ");
                    insNum = input.nextInt();

                    //query the number of doses that this person already took
                    String retrieveDoses = "" +
                            "SELECT COUNT(insNum), vnumdoses, vwaitperiod, MAX(vdate) " +
                            "FROM SLOT s, VACCINE v " +
                            "WHERE s.vaccine = v.vname AND s.insNum = "+ insNum + " AND  s.vialid is NOT NULL " +
                            "GROUP BY vnumdoses, vwaitperiod, vdate;";
                    java.sql.ResultSet rs = statement.executeQuery ( retrieveDoses );

                    int tookDoses = 0;
                    int vnumdose = 0;
                    int vwaitperiod = 0;
                    String lastVacDate = "";

                    while(rs.next()) {
                        tookDoses += rs.getInt(1);
                        vnumdose = rs.getInt(2);
                        vwaitperiod = rs.getInt(3);
                        lastVacDate = rs.getString(4);
                    }

                    if(tookDoses == vnumdose && vnumdose != 0){
                        System.out.println("Person have already took all necessary doses");
                        choice = menu();
                    }

                    String availSlots;
                    if(vnumdose != 0){
                        //display all available dates
                        availSlots = "" +
                                "SELECT location, vdate, vtime, sid " +
                                "FROM SLOT " +
                                "WHERE vdate > current date AND vdate >  DATE '"+ lastVacDate+" ' + "+ vwaitperiod + " DAYS and vialid is NULL;";

                    }else{
                        availSlots = "" +
                                "SELECT location, vdate, vtime, sid " +
                                "FROM SLOT " +
                                "WHERE vdate > current date AND vialid is NULL;";
                    }

                    java.sql.ResultSet res = statement.executeQuery ( availSlots );
                    //check if there are available slots
                    if (res.next() == false) {
                        System.out.println("No available slots at the moment");
                        choice = menu();
                    }

                    List<Integer> slotList = new ArrayList<Integer>();
                    int temp = 1;
                    while (res.next()) {
//                    System.out.println(temp +". " + res.getString(1) + ", " + res.getString(2) + ", " + res.getString(3));
                        temp++;

                        //add sid to a list
                        slotList.add(res.getInt(4));
                    }

                    //selected slot
                    int slotNum = selectNum();
                    slotNum = slotList.get(slotNum-1);

                    //now we have the sid and we can register
                    if(confirmation()){
                        String updateSlot =
                                "UPDATE SLOT " +
                                        "SET insNum=" + insNum +
                                        ", asndate = CURRENT DATE " +
                                        " WHERE sid = " + slotNum + " ;";
                        statement.executeUpdate( updateSlot );
                        System.out.println("Succesfully added a person to a  slot");
                    }

                    choice = menu();

                }else if(choice == 3) {
                    System.out.println("Please enter separated by comma: slot id, insurance number, licencenum, vaccine name, vaccine company, batch id, and vial id.");
                    String vacInfo;
                    Scanner input = new Scanner(System.in);
                    vacInfo = input.nextLine();
                    String[] infoslist = vacInfo.split(",");
                    String insNum = infoslist[1];
                    String vaccine = infoslist[3].replaceAll("\\s+","");

                    String lastVaccine = "SELECT vaccine " +
                            "FROM SLOT " +
                            "WHERE insNum=" + insNum + " AND vialid is not null;";
                    java.sql.ResultSet r = statement.executeQuery(lastVaccine);

                    // check if same vaccine
                    //a vaccine was administered, so we just need to compare
                    if (r.next()) {
                        String v = r.getString(1).replaceAll("\\s+","");
                        if (!vaccine.equals(v)) {
                            System.out.println("You can't administer a vaccine that's different from the last one.");
                            choice = menu();
                        }
                    }

//                System.out.println(infoslist[4]);
                    //update the slot
                    if (confirmation()) {
                        String updateSlot =
                                "UPDATE SLOT " +
                                        "SET insNum = " + insNum +
                                        ", asndate = CURRENT DATE " +
                                        ", licensenum = " + infoslist[2] +
                                        ", vaccine = '" + infoslist[3].replaceAll("\\s+","") + "' " +
                                        ", vbcompany = '" + infoslist[4].replaceAll("\\s+","") + "' " +
                                        " , vbid = " + infoslist[5] +
                                        ", vialid = " + infoslist[6] +
                                        " WHERE sid = " + infoslist[0] + " ;";
                        statement.executeUpdate(updateSlot);
                        System.out.println("Successfully updated the slot\n");
                    }
                    choice = menu();
                }else if(choice == 4){
                    System.out.println("See you soon~");
                    statement.close ( ) ;
                    con.close ( ) ;
                }
            }

//      Finally but importantly close the statement and connection
            statement.close ( ) ;
            con.close ( ) ;
        }

}
