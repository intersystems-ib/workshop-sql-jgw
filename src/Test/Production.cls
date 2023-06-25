Class Test.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Test.Production" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="EnsLib.JavaGateway.Service" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Address">jgw</Setting>
    <Setting Target="Host" Name="ClassPath">/jgw/mysql-connector-java-8.0.30.jar</Setting>
    <Setting Target="Host" Name="JavaHome">/usr/local/openjdk-8</Setting>
    <Setting Target="Host" Name="Port">44444</Setting>
  </Item>
  <Item Name="EnsLib.SQL.Service.GenericService" Category="" ClassName="EnsLib.SQL.Service.GenericService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="JDBCClasspath"></Setting>
    <Setting Target="Adapter" Name="JDBCDriver">com.mysql.jdbc.Driver</Setting>
    <Setting Target="Adapter" Name="JGService">EnsLib.JavaGateway.Service</Setting>
    <Setting Target="Adapter" Name="DSN">jdbc:mysql://mysql:3306/test</Setting>
    <Setting Target="Adapter" Name="Credentials">MySQL_User</Setting>
    <Setting Target="Host" Name="MessageClass">Test.Patient</Setting>
    <Setting Target="Adapter" Name="Query">select Id, Name, Lastname from patient</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Test.PatientToString</Setting>
  </Item>
  <Item Name="EnsLib.File.PassthroughOperation" Category="" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Filename">patients.txt</Setting>
    <Setting Target="Adapter" Name="FilePath">/tmp/out</Setting>
  </Item>
  <Item Name="Test.PatientToString" Category="" ClassName="Test.PatientToString" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="EnsLib.SQL.Operation.GenericOperation" Category="" ClassName="EnsLib.SQL.Operation.GenericOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">MySQL_User</Setting>
    <Setting Target="Adapter" Name="DSN">jdbc:mysql://mysql:3306/test</Setting>
    <Setting Target="Adapter" Name="JDBCDriver">com.mysql.jdbc.Driver</Setting>
    <Setting Target="Adapter" Name="JGService">EnsLib.JavaGateway.Service</Setting>
    <Setting Target="Host" Name="RequestClass">Test.Patient</Setting>
    <Setting Target="Host" Name="InputParameters">*Id,*Name,*Lastname</Setting>
    <Setting Target="Host" Name="Query">insert into patient (ID, Name, Lastname) values (?, ?, ?)</Setting>
    <Setting Target="Host" Name="ParamSQLTypes"></Setting>
  </Item>
</Production>
}

}
