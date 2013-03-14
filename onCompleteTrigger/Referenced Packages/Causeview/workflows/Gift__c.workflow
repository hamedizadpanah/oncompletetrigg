<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>UpdateNullNPD</fullName>
        <description>Updates NULL next payment date.</description>
        <field>Next_Payment_Date__c</field>
        <formula>If(ISNULL(Last_Payment_Date__c) &amp;&amp; Recurring_Donation__r.Start_Date__c &gt; Today (), Recurring_Donation__r.Start_Date__c, IF(ISPICKVAL(Recurring_Donation__r.Frequency__c, &quot;Monthly&quot;), (DATE((YEAR(Recurring_Donation__r.Start_Date__c)+FLOOR(((MONTH(Recurring_Donation__r.Start_Date__c)+ 1)-1)/12)),MOD((MONTH(Recurring_Donation__r.Start_Date__c)+ 1)-1,12)+1,DAY(Recurring_Donation__r.Start_Date__c))), IF(ISPICKVAL(Recurring_Donation__r.Frequency__c, &quot;Quarterly&quot;), (DATE((YEAR(Recurring_Donation__r.Start_Date__c)+FLOOR(((MONTH(Recurring_Donation__r.Start_Date__c)+ 3)-1)/12)),MOD((MONTH(Recurring_Donation__r.Start_Date__c)+ 3)-1,12)+1,DAY(Recurring_Donation__r.Start_Date__c))), IF(ISPICKVAL(Recurring_Donation__r.Frequency__c, &quot;Annually&quot;), (DATE((YEAR(Recurring_Donation__r.Start_Date__c)+FLOOR(((MONTH(Recurring_Donation__r.Start_Date__c)+ 12)-1)/12)),MOD((MONTH(Recurring_Donation__r.Start_Date__c)+ 12)-1,12)+1,DAY(Recurring_Donation__r.Start_Date__c))), Today()))))</formula>
        <name>UpdateNullNPD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WriteNextPaymentDate</fullName>
        <description>Writes the next payment date for recurring transactions.</description>
        <field>Next_Payment_Date__c</field>
        <formula>If( Recurring_Donation__r.Start_Date__c &gt; Today(),  Recurring_Donation__r.Start_Date__c, IF(ISPICKVAL(Recurring_Donation__r.Frequency__c, &quot;Monthly&quot;), (DATE((YEAR(Recurring_Donation__r.Start_Date__c)+FLOOR(((MONTH(Recurring_Donation__r.Start_Date__c)+ 1)-1)/12)),MOD((MONTH(Recurring_Donation__r.Start_Date__c)+ 1)-1,12)+1,DAY(Recurring_Donation__r.Start_Date__c))), IF(ISPICKVAL(Recurring_Donation__r.Frequency__c, &quot;Quarterly&quot;), (DATE((YEAR(Recurring_Donation__r.Start_Date__c)+FLOOR(((MONTH(Recurring_Donation__r.Start_Date__c)+ 3)-1)/12)),MOD((MONTH(Recurring_Donation__r.Start_Date__c)+ 3)-1,12)+1,DAY(Recurring_Donation__r.Start_Date__c))), IF(ISPICKVAL(Recurring_Donation__r.Frequency__c, &quot;Annually&quot;), (DATE((YEAR(Recurring_Donation__r.Start_Date__c)+FLOOR(((MONTH(Recurring_Donation__r.Start_Date__c)+ 12)-1)/12)),MOD((MONTH(Recurring_Donation__r.Start_Date__c)+ 12)-1,12)+1,DAY(Recurring_Donation__r.Start_Date__c))), Today()))))</formula>
        <name>WriteNextPaymentDate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>NULLNextPaymentDate</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Gift__c.Next_Payment_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Gift__c.Gift_Type__c</field>
            <operation>equals</operation>
            <value>Recurring</value>
        </criteriaItems>
        <criteriaItems>
            <field>Gift__c.Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>Updates recurring transaction next payment date if NULL.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>UpdateNextPaymentDate</fullName>
        <actions>
            <name>WriteNextPaymentDate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Updates the next payment date when a recurring gift record is created.</description>
        <formula>NOT(ISBLANK(Recurring_Donation__c)) &amp;&amp;   (ISPICKVAL(Status__c, &quot;Active&quot;)) &amp;&amp; (ISPICKVAL(Gift_Type__c, &quot;Recurring&quot;)) &amp;&amp;  (Recurring_Donation__r.Start_Date__c &gt; TODAY())</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
