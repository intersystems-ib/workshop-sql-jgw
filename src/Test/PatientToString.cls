/// 
Class Test.PatientToString Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Test.Patient' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='patientStream' type='Ens.StreamContainer' instantiate='0' />
</context>
<sequence xend='200' yend='450' >
<code xpos='200' ypos='250' >
<![CDATA[ set context.patientStream = ##class(Ens.StreamContainer).%New()

 set stream = ##class(%Stream.GlobalCharacter).%New()

 do stream.Write(request.Id_" "_request.Name_" "_request.Lastname_$Char(13)_$Char(10))

 set context.patientStream.Stream=stream   ]]>
</code>
<call name='Invoke file operation' target='EnsLib.File.PassthroughOperation' async='1' xpos='200' ypos='350' >
<request type='Ens.StreamContainer' >
<assign property="callrequest" value="context.patientStream" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</process>
}

}
