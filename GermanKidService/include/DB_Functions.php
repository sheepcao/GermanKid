<?php

class DB_Functions {

    private $db;

    //put your code here
    // constructor
    function __construct() {
        require_once 'DB_Connect.php';
        // connecting to database
        $this->db = new DB_Connect();
        $this->db->connect();
    }

    // destructor
    function __destruct() {
        
    }


    /**
     * Get product info
     */
    public function getCategory($name) {
        $result = mysql_query("SELECT * FROM categoryinfo where menu_category = '$name'") or die(mysql_error());
        // check for result 
        $no_of_rows = mysql_num_rows($result);
        if ($no_of_rows > 0) {
//            $result = mysql_fetch_array($result);
            return $result;

        } else {
            // user not found
            return false;
        }
    }
    
    public function getAllproduct() {
        $result = mysql_query("SELECT * FROM productinfo") or die(mysql_error());
        // check for result
        $no_of_rows = mysql_num_rows($result);
        if ($no_of_rows > 0) {
//            $result = mysql_fetch_array($result);
            return $result;
            
        } else {
            // user not found
            return false;
        }
    }
    
    public function getEntireProduct($name) {
        $result = mysql_query("SELECT * FROM productinfo where name = '$name'") or die(mysql_error());
        // check for result
        $no_of_rows = mysql_num_rows($result);
        if ($no_of_rows > 0) {
            $result = mysql_fetch_array($result);
            return $result;
            
        } else {
            // user not found
            return false;
        }
    }
    
    public function getAllSettings() {
        $result = mysql_query("SELECT * FROM settinginfo") or die(mysql_error());
        // check for result
        $no_of_rows = mysql_num_rows($result);
        if ($no_of_rows > 0) {
            $result = mysql_fetch_array($result);
            return $result;
            
        } else {
            // user not found
            return false;
        }
    }
    
    public function getAllBanners() {
        $result = mysql_query("SELECT * FROM bannerinfo") or die(mysql_error());
        // check for result
        $no_of_rows = mysql_num_rows($result);
        if ($no_of_rows > 0) {
//            $result = mysql_fetch_array($result);
            return $result;
            
        } else {
            // user not found
            return false;
        }
    }




    /**
     * Get productInfo by name
     */
    public function getDetailByName($name) {
        $result = mysql_query("SELECT * FROM descriptioninfo WHERE related_product = '$name'") or die(mysql_error());
        // check for result
        $no_of_rows = mysql_num_rows($result);
        if ($no_of_rows > 0) {
//            $result = mysql_fetch_array($result);
            return $result;
        }else {
        // user not found
        return $result;
        }
    }

    



}

?>
