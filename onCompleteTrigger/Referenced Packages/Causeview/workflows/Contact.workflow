<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>UpdateAddressee</fullName>
        <description>Updates individual primary addressee with household value.</description>
        <field>Primary_Addressee__c</field>
        <formula>Household__r.Household_Addressee__c</formula>
        <name>UpdateAddressee</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateBlankAddressee</fullName>
        <description>Updates Primary Addressee field with default value</description>
        <field>Primary_Addressee__c</field>
        <formula>IF (ISPICKVAL(Salutation,&quot;&quot;), 
(FirstName &amp; &quot; &quot; &amp; LastName),
(TEXT(Salutation) &amp; &quot; &quot; &amp;  FirstName &amp; &quot; &quot; &amp; LastName)
)</formula>
        <name>UpdateBlankAddressee</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateBlankSalutation</fullName>
        <description>Auto populates the Salutation field with first name</description>
        <field>Primary_Salutation__c</field>
        <formula>FirstName</formula>
        <name>UpdateBlankSalutation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateHouseholdAddress</fullName>
        <description>Updates mailing address from household.</description>
        <field>MailingStreet</field>
        <formula>Household__r.BillingStreet</formula>
        <name>UpdateHouseholdAddress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateHouseholdCity</fullName>
        <description>Updates mailing city from household.</description>
        <field>MailingCity</field>
        <formula>Household__r.BillingCity</formula>
        <name>UpdateHouseholdCity</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateHouseholdCountry</fullName>
        <description>Updates mailing country from household.</description>
        <field>MailingCountry</field>
        <formula>Household__r.BillingCountry</formula>
        <name>UpdateHouseholdCountry</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateHouseholdPhone</fullName>
        <description>Updates home phone from household.</description>
        <field>HomePhone</field>
        <formula>Household__r.Phone</formula>
        <name>UpdateHouseholdPhone</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateHouseholdPostal</fullName>
        <description>Updates mailing postal/zip code from household.</description>
        <field>MailingPostalCode</field>
        <formula>Household__r.BillingPostalCode</formula>
        <name>UpdateHouseholdPostal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateHouseholdState</fullName>
        <description>Updates mailing state from household.</description>
        <field>MailingState</field>
        <formula>Household__r.BillingState</formula>
        <name>UpdateHouseholdState</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateSalutation</fullName>
        <description>Updates individual primary salutation with household value.</description>
        <field>Primary_Salutation__c</field>
        <formula>Household__r.Household_Salutation__c</formula>
        <name>UpdateSalutation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Household Info</fullName>
        <actions>
            <name>UpdateHouseholdAddress</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UpdateHouseholdCity</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UpdateHouseholdCountry</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UpdateHouseholdPhone</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UpdateHouseholdPostal</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UpdateHouseholdState</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Same_as_Household__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Updates address and phone number from Household.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>HouseholdAddresseeSalutation</fullName>
        <actions>
            <name>UpdateAddressee</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UpdateSalutation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Use_Household_Salutation_Addressee__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Updates contact values with household addressee and salutation.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UpdateAddressee</fullName>
        <actions>
            <name>UpdateBlankAddressee</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Primary_Addressee__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates Addressee field if blank.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UpdateSalutation</fullName>
        <actions>
            <name>UpdateBlankSalutation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Primary_Salutation__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Checks to see if Primary Salutation is blank and populates default</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
