Class Test.Patient Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor, Ens.Request)
{

Property Id As %Integer;

Property Name As %String;

Property Lastname As %String;

Storage Default
{
<Data name="PatientDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Id</Value>
</Value>
<Value name="3">
<Value>Name</Value>
</Value>
<Value name="4">
<Value>Lastname</Value>
</Value>
</Data>
<DataLocation>^Test.PatientD</DataLocation>
<DefaultData>PatientDefaultData</DefaultData>
<IdLocation>^Test.PatientD</IdLocation>
<IndexLocation>^Test.PatientI</IndexLocation>
<StreamLocation>^Test.PatientS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
