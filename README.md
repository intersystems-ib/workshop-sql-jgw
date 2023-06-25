# workshop-sql-jgw
Example about an IRIS production connected by JDBC to a MySQL database throught JGW

You can find more in-depth information in https://learning.intersystems.com.

New to IRIS Interoperability framework? Have a look at [IRIS Interoperability Intro Workshop](https://github.com/intersystems-ib/workshop-interop-intro).

# What do you need to install? 
* [Git](https://git-scm.com/downloads) 
* [Docker](https://www.docker.com/products/docker-desktop) (if you are using Windows, make sure you set your Docker installation to use "Linux containers").
* [Docker Compose](https://docs.docker.com/compose/install/)
* [Visual Studio Code](https://code.visualstudio.com/download) + [InterSystems ObjectScript VSCode Extension](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript)

# Setup
Build the image we will use during the workshop:

```console
$ git clone https://github.com/intersystems-ib/workshop-sql-jgw
$ cd workshop-sql-jgw
$ docker-compose build
```

# Example

The main purpose of this example is to get all new data recorded into Patient table and make it accesible from a production in IRIS. You will also be able to write some record into MySQL table.

Run the containers we will use in the workshop:
```
docker-compose up
```

## MySQL

* Open [Adminer](http://localhost:8080) using the following parameters:
  * Server: `mysql`
  * Username: `root`
  * Password: `SYS`
  * Database: `test`
* Review the records in Patient table.

## IRIS 

Automatically an IRIS instance will be deployed and a production will be configured and run to read new records from a MySQL database.

### Test Production

#### Read data from MySQL table

* Open the [Management Portal](http://localhost:52773/csp/sys/UtilHome.csp).
* Login using the default `superuser`/ `SYS` account.
* Click on [Test Production](http://localhost:52773/csp/user/EnsPortal.ProductionConfig.zen?$NAMESPACE=USER&$NAMESPACE=USER&) to access the sample production that we are going to use. You can access also through *Interoperability > User > Configure > Production*.
* Click on `EnsLib.JavaGateway.Service` and review the configuration.
  * You will notice that a jar file is defined to configure the JDBC connection to the specific database engine, if you want to test another engine you should add the new jar path into Class Path field.
* Do the same for `EnsLib.SQL.Service.GenericService`. Open Messages tab and check it, you can see that there is a message for each row in the table.
* Try to insert a new record into Patient table (you can do it from Adminer), you will see a new message received in the production.

Opening Visual Studio Code you will be able to review the business operation used to read the object created for each row in Patient's table and the object definition

Code to read the patient's object:

```objectscript
 set context.patientStream = ##class(Ens.StreamContainer).%New()
 set stream = ##class(%Stream.GlobalCharacter).%New()
 do stream.Write(request.Id_" "_request.Name_" "_request.Lastname_$Char(13)_$Char(10))
 set context.patientStream.Stream=stream
```

Patient's object definition:

```objectscript
Class Test.Patient Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor, Ens.Request)
{

Property Id As %Integer;

Property Name As %String;

Property Lastname As %String;

}
```

#### Write data to MySQL table
* Check the `EnsLib.SQL.Service.Operation` operation in your production.
* This operation will insert new records in the patient table in MySQL.
* To test it simply click on it and *Actions* tab > *Test*
  * Set the test request type to: `Test.Patient`
  * Fill out some values for *Id*, *Name* and *LastName*
  * Test your request
* After testing the operation, you can check that the new records are created in MySQL table
