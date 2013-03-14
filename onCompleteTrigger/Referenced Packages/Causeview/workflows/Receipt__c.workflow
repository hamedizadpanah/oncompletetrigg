<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Receipt_Email_Send</fullName>
        <description>Receipt Email Send</description>
        <protected>false</protected>
        <recipients>
            <field>Constituent__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>Receipt_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Giving_Power/CreditCardUpdate</template>
    </alerts>
    <fieldUpdates>
        <fullName>DateIssued</fullName>
        <description>Assign the date Issued to the receipt</description>
        <field>Date_Issued__c</field>
        <formula>TODAY()</formula>
        <name>DateIssued</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Issued</fullName>
        <description>Changes the recordtype to Issued</description>
        <field>RecordTypeId</field>
        <lookupValue>Issued</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Issued</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Receipt_to_Issued</fullName>
        <description>Sets receipt record type to Issued (read-only).</description>
        <field>RecordTypeId</field>
        <lookupValue>Issued</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Receipt to Issued</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateReceiptAddress_Org</fullName>
        <description>Updates receipt address field with Organization&apos;s address.</description>
        <field>Receipt_Address__c</field>
        <formula>Gift__r.Organization__r.BillingStreet   &amp; BR()
&amp; Gift__r.Organization__r.BillingCity &amp; &quot;, &quot; &amp; Gift__r.Organization__r.BillingState &amp; &quot; &quot; &amp; Gift__r.Organization__r.BillingPostalCode &amp; &quot; &quot; &amp; Gift__r.Organization__r.BillingCountry</formula>
        <name>UpdateReceiptAddress (Org)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateReceiptLetterTxt2</fullName>
        <description>Updates Letter - Text Block field with Plain text value from Letter.</description>
        <field>Letter_Text_Block__c</field>
        <formula>Gift__r.Letter__r.Text_Block__c</formula>
        <name>UpdateReceiptLetterTxt</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateReceiptName_Org</fullName>
        <description>Updates receipt name with Organization&apos;s name.</description>
        <field>Receipt_Name__c</field>
        <formula>Gift__r.Organization__r.Name</formula>
        <name>UpdateReceiptName (Org)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Receipt_Address</fullName>
        <description>Captures receipt address from Account record.</description>
        <field>Receipt_Address__c</field>
        <formula>Gift__r.Constituent__r.MailingStreet &amp; BR()
&amp; Gift__r.Constituent__r.MailingCity &amp; &quot;, &quot; &amp; Gift__r.Constituent__r.MailingState &amp; &quot; &quot; &amp; Gift__r.Constituent__r.MailingPostalCode &amp; &quot; &quot; &amp; Gift__r.Constituent__r.MailingCountry</formula>
        <name>Update Receipt Address</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Receipt_Name</fullName>
        <description>Updates receipt name with constituent name when receipt record is created.</description>
        <field>Receipt_Name__c</field>
        <formula>Gift__r.Constituent__r.FirstName &amp; &quot; &quot; &amp; Gift__r.Constituent__r.LastName</formula>
        <name>Update Receipt Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>IssueReceipt</fullName>
        <actions>
            <name>DateIssued</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Issued</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Receipt__c.Status__c</field>
            <operation>equals</operation>
            <value>Issued</value>
        </criteriaItems>
        <description>Changes the receipt&apos;s recordtype when the status is updated.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Receipt Issued</fullName>
        <actions>
            <name>Receipt_to_Issued</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Receipt__c.Status__c</field>
            <operation>equals</operation>
            <value>Issued</value>
        </criteriaItems>
        <description>Changes the receipt to read-only record type when record has been issued.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Write Receipt Address</fullName>
        <actions>
            <name>Update_Receipt_Address</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Captures point in time receipt address.</description>
        <formula>NOT(ISBLANK(Gift__r.Constituent__c ))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Write Receipt Name</fullName>
        <actions>
            <name>Update_Receipt_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Captures point in time constituent name for receipt.</description>
        <formula>NOT(ISBLANK(Gift__r.Constituent__c))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WriteReceiptAddress %28Org%29</fullName>
        <actions>
            <name>UpdateReceiptAddress_Org</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Writes receipt address for Organizational gifts.</description>
        <formula>NOT(ISBLANK(Gift__r.Organization__c ))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WriteReceiptName %28Org%29</fullName>
        <actions>
            <name>UpdateReceiptName_Org</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Writes receipt name for organizational gifts.</description>
        <formula>NOT(ISBLANK(Gift__r.Organization__c))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
