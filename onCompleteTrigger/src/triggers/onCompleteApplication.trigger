trigger onCompleteApplication on Application__c (before Insert, before Update) {
    for(Application__c appObj:Trigger.new){
        if(appObj.HR_Admin_Approved__c==True && appObj.HR_Payroll_Approved__c== True && appObj.Status__c!='Completed'){
            if((appObj.Stipend_amount__c !=0 && appObj.Begin_Effective_Date__c!= Null) || (appObj.Stipend_amount__c == 0 ||appObj.Stipend_amount__c == null && appObj.Begin_Effective_Date__c == Null) ){
                List<appCompTrig__c> configObj=[Select IHOP_overall_ID__c,Contact_Record_Type_Id__c,Campaign_Record_Type_Id__c,Overall_Parent_Campaign_Id__c,Overall_Fund_Id__c From appCompTrig__c aT Limit 1];
                if (!configObj.isEmpty()){
                    Id staffContactId=null;
                    String fullName='';
                    List<Campaign> testCamp=new List<Campaign>();
                    
                    if(appObj.Existing_Staff_Contact__c == null){
                        fullName= appObj.First_Name__c + ' ' + appObj.Last_Name__c;
                        Contact staffCont= New Contact(FirstName = appObj.First_Name__c,
                                                        LastName=appObj.Last_Name__c,
                                                        Birthdate=appObj.Birthdate__c,
                                                        MailingStreet=appObj.Street__c,
                                                        MailingCity=appObj.City__c,
                                                        MailingState=appObj.State__c,
                                                        MailingPostalCode=appObj.Zip__c,
                                                        Email=appObj.Email_Address_1__c,
                                                        Phone=appObj.Phone__c,
                                                        MobilePhone=appObj.Cell_phone__c,
                                                        AccountId=configObj[0].IHOP_overall_ID__c,
                                                        ReportsToId=appObj.Report_to__c,
                                                        Staff_Designation__c=appObj.Employment_Type__c,
                                                        RecordTypeId=configObj[0].Contact_Record_Type_Id__c
                                                        );
                        insert staffCont;
                        staffContactId = staffCont.Id;
                        appObj.Existing_Staff_Contact__c = staffContactId ;
    
                    }else{
                        Contact existContact=[Select FirstName,LastName,Birthdate,MailingStreet,MailingCity,MailingState,MailingPostalCode,Email,Phone,MobilePhone from Contact cont where Id =:appObj.Existing_Staff_Contact__c];
                        fullName=existContact.FirstName + ' ' + existContact.LastName;
                        appObj.First_Name__c=existContact.FirstName;
                        appObj.Last_Name__c=existContact.LastName;
                        appObj.Birthdate__c=existContact.Birthdate;
                        appObj.Street__c=existContact.MailingStreet;
                        appObj.City__c=existContact.MailingCity;
                        appObj.State__c=existContact.MailingState;
                        appObj.Zip__c=existContact.MailingPostalCode;
                        appObj.Email_Address_1__c=existContact.Email;
                        appObj.Phone__c=existContact.Phone;
                        appObj.Cell_phone__c=existContact.MobilePhone;
                        staffContactId = appObj.Existing_Staff_Contact__c;
                        
                        testCamp = [select Id From Campaign camTest where Staff_Contact__c =:appObj.Existing_Staff_Contact__c and IsActive=True and RecordTypeId =:configObj[0].Campaign_Record_Type_Id__c];
                    }
                    
                    Employment_record__c er=new Employment_record__c(Application__c = appObj.Id,Contact__c=staffContactId,Start_Date__c=Date.today(),Status__c='Active');
                    Insert er;
                    
                    If (appObj.Stipend_amount__c != null && appObj.Stipend_amount__c > 0 ){
                    	Missionary_Stipend__c stipend=New Missionary_Stipend__c(Department__c=appObj.Department__c,
                                                                    Begin_Effective_Date__c=appObj.Begin_Effective_Date__c,
                                                                    Stipend_amount__c=appObj.Stipend_amount__c,
                                                                    Employment_record__c=er.Id);
                    	insert stipend;
                    }
                    
                    If(testCamp.isEmpty()){
                        Campaign campRec=New Campaign(Name=fullName + ' Staff Support - '+appObj.Email_Address_1__c,
                                                        RecordTypeId=configObj[0].Campaign_Record_Type_Id__c,
                                                        Status = 'In Progress',
                                                        IsActive=True,
                                                        StartDate=Date.Today(),
                                                        Description = 'Staff support campaign for the ministry of ' + fullName + ' at IHOPKC.',
                                                        Staff_Contact__c=staffContactId,
                                                        ParentId=configObj[0].Overall_Parent_Campaign_Id__c,
                                                        causeview__Fund__c=configObj[0].Overall_Fund_Id__c
                                                         );
                        insert campRec;
                    }
                    
                    appObj.Status__c='Completed';
                }
            }
        }
    }
}