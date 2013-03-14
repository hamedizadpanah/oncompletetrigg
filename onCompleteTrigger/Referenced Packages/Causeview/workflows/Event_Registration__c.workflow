<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CheckedInStatus</fullName>
        <field>Status__c</field>
        <literalValue>Attended</literalValue>
        <name>CheckedInStatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>CheckIn</fullName>
        <actions>
            <name>CheckedInStatus</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event_Registration__c.Checked_In__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Changes status from Registered to Attended when the attendee checks in</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
