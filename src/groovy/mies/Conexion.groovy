package mies

import groovy.sql.Sql

abstract class Conexion {


  /**
   * Instancia de la connexión a la BD
   */
  def db
  def url
  def driver
  def user
  def password
  //protected ds
  boolean connected = false

  /**
   * Función para setear el driver y el url
   */

  abstract void setServer(strServer,strDB)

  protected void setServer(strUrl, strDriver, strUsername, strPassword){
    driver = strDriver
    url = strUrl
    user = strUsername
    password = strPassword
  }

  boolean connect(strUrl,strDriver,strUser,strPassword) {

    try {

      if(connected) {
        disconnect();
      }
      setServer(strUrl, strDriver, strUser, strPassword)
      db = Sql.newInstance(url,user,password,driver)


      connected = true
    } catch(Exception ex) {
      db = null
      connected = false
      //println ex.stackTrace
      println ex.message
    }
    return connected
  }


  /**
   * Ejecuta una sentencia SQL
   * @param: String strSql
   */
  boolean execSql(String strSql) {
    if(connected) {
      boolean bresult = true
      try {
        db.execute strSql
      } catch(Exception ex) {
        bresult = false
        println "ERROR: execSql(String) cannot execute ''" + strSql + "'"
        println ex.message
      }
      return bresult
    }
    else
      return false
  }



  /**
   * Cierra la conexión con la BD
   */
  void disconnect() {

    if(db != null) {
      db.close()
    }
    db = null
  }

}

// === MS-SqlServer connection ===
class SQLSERVERConnection extends Conexion {

  void setServer(strServer,strDB) {
    driver = 'com.microsoft.jdbc.sqlserver.SQLServerDriver'
    url = "jdbc:microsoft:sqlserver://$strServer:1433;databaseName=$strDB"
  }
}

// === MySQL connection ===
class MySqlConnection extends Conexion {

  void setServer(strServer,strDB) {
    driver = 'com.mysql.jdbc.Driver'
    url = "jdbc:mysql://$strServer:3306/$strDB"
  }
}

//=== PostgreSQL connection ===
class PgSqlConnection extends Conexion {

  void setServer(strServer,strDB) {
    driver = 'org.postgresql.Driver'
    url = "jdbc:postgresql://$strServer:5432/$strDB"
  }
}

// === Factory Class ===
class ConnectionFactory {

  static Conexion getConnection(dbType) {

    if(dbType == 'MySQL') {
      return new MySqlConnection()
    } else {
      if(dbType == 'MS-SqlServer') {
        return new SQLSERVERConnection()
      } else {
        if(dbType == 'PgSql') {
          return new PgSqlConnection()
        } else {
          println "not a valid connection..."
          return null ;
        }
      }
    }
  }
  /*static Connection getConnection(DataSource DS) {

  switch (DS.driverClassName) {
      case "org.mysql.Driver":
          return new MySqlConnection(DS)

      case "org.mssql.Driver":
          return new SQLSERVERConnection(DS)

      case "org.postgresql.Driver":
          return new PgSqlConnection(DS)

      default:
              println "DS---------->" + DS.driverClassName + "not a valid connection..."
              //return null ;
              return new PgSqlConnection(DS)

      }
  }*/

}
