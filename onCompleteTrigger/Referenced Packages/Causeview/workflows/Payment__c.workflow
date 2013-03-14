<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>UpdateNextPaymentDate</fullName>
        <description>Calculates next payment date when a new payment is made towards gift.</description>
        <field>Next_Payment_Date__c</field>
        <formula>IF( NOT(ISNULL(Donation__r.Next_Payment_Date__c)), 
IF(ISPICKVAL( Donation__r.Recurring_Donation__r.Frequency__c , &quot;Monthly&quot;), (DATE((YEAR( Donation__r.Next_Payment_Date__c )+FLOOR(((MONTH(Donation__r.Next_Payment_Date__c)+ 1)-1)/12)),MOD((MONTH(Donation__r.Next_Payment_Date__c)+ 1)-1,12)+1,DAY(Donation__r.Next_Payment_Date__c))), IF(ISPICKVAL(Donation__r.Recurring_Donation__r.Frequency__c, &quot;Quarterly&quot;), (DATE((YEAR(Donation__r.Next_Payment_Date__c)+FLOOR(((MONTH(Donation__r.Next_Payment_Date__c)+ 3)-1)/12)),MOD((MONTH(Donation__r.Next_Payment_Date__c)+ 3)-1,12)+1,DAY(Donation__r.Next_Payment_Date__c))), IF(ISPICKVAL(Donation__r.Recurring_Donation__r.Frequency__c, &quot;Annually&quot;), (DATE((YEAR(Donation__r.Next_Payment_Date__c)+FLOOR(((MONTH(Donation__r.Next_Payment_Date__c)+ 12)-1)/12)),MOD((MONTH(Donation__r.Next_Payment_Date__c)+ 12)-1,12)+1,DAY(Donation__r.Next_Payment_Date__c))), Today()))),

IF(ISPICKVAL( Donation__r.Recurring_Donation__r.Frequency__c , &quot;Monthly&quot;), (DATE((YEAR( Donation__r.Recurring_Start_Date__c  )+FLOOR(((MONTH(Donation__r.Recurring_Start_Date__c )+ 1)-1)/12)),MOD((MONTH(Donation__r.Recurring_Start_Date__c )+ 1)-1,12)+1,DAY(Donation__r.Recurring_Start_Date__c ))), IF(ISPICKVAL(Donation__r.Recurring_Donation__r.Frequency__c, &quot;Quarterly&quot;), (DATE((YEAR(Donation__r.Recurring_Start_Date__c )+FLOOR(((MONTH(Donation__r.Recurring_Start_Date__c )+ 3)-1)/12)),MOD((MONTH(Donation__r.Recurring_Start_Date__c )+ 3)-1,12)+1,DAY(Donation__r.Recurring_Start_Date__c ))), IF(ISPICKVAL(Donation__r.Recurring_Donation__r.Frequency__c, &quot;Annually&quot;), (DATE((YEAR(Donation__r.Recurring_Start_Date__c )+FLOOR(((MONTH(Donation__r.Recurring_Start_Date__c )+ 12)-1)/12)),MOD((MONTH(Donation__r.Recurring_Start_Date__c )+ 12)-1,12)+1,DAY(Donation__r.Recurring_Start_Date__c ))), Today())))

)</formula>
        <name>UpdateNextPaymentDate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Donation__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateRT_CC</fullName>
        <description>Updates payment recordtype to Credit Card.</description>
        <field>RecordTypeId</field>
        <lookupValue>Credit_Card</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>UpdateRT_CC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateRT_Refunded</fullName>
        <description>Update recordtype field to Refund.</description>
        <field>RecordTypeId</field>
        <lookupValue>Refund</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>UpdateRT_Refunded</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WriteLastPaymentDate</fullName>
        <description>Writes last payment date with the payment date.</description>
        <field>Last_Payment_Date__c</field>
        <formula>Date__c</formula>
        <name>WriteLastPaymentDate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Donation__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>UpdatePaymentDates</fullName>
        <actions>
            <name>UpdateNextPaymentDate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>WriteLastPaymentDate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Payment__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Payment__c.Amount__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Payment__c.Status__c</field>
            <operation>equals</operation>
            <value>Deposited,Approved</value>
        </criteriaItems>
        <description>Updates last  and next payment dates on transaction when a new payment is created.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>UpdatePaymentRT_CC</fullName>
        <actions>
            <name>UpdateRT_CC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Payment__c.Payment_Type__c</field>
            <operation>equals</operation>
            <value>Credit Card</value>
        </criteriaItems>
        <criteriaItems>
            <field>Payment__c.Status__c</field>
            <operation>equals</operation>
            <value>Deposited,Approved</value>
        </criteriaItems>
        <description>Updates payment recordtype to Credit Card.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>UpdatePaymentRT_Refund</fullName>
        <actions>
            <name>UpdateRT_Refunded</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Payment__c.Status__c</field>
            <operation>equals</operation>
            <value>Refunded</value>
        </criteriaItems>
        <criteriaItems>
            <field>Payment__c.Payment_Type__c</field>
            <operation>equals</operation>
            <value>Credit Card</value>
        </criteriaItems>
        <description>Sets Payment recordtype to Refund when payment status is Refunded.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
