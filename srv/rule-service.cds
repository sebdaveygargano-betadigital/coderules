using {codeRules} from '../db/schema';

service RuleService @(path: '/codeRuleService') {


    @Capabilities.InsertRestrictions.Insertable: false
    @Capabilities.UpdateRestrictions.Updatable : false
    @Capabilities.DeleteRestrictions.Deletable : false
    entity BaseRules as projection on codeRules.BaseRule;

    @odata.draft.enabled
    entity CodeUsers as
        projection on codeRules.CodeUser {
            ID,
            modifiedAt,
            createdBy,
            createdAt,
            modifiedBy,
            rules
        };


    // UserRules — child of CodeUser, draft handled by parent
    entity UserRules as
        projection on codeRules.UserRule {
            ID,
            user,

            effectiveDate,
            endDate,

            @(Common.ValueList: {
                entity    : 'BaseRules',
                parameters: [
                    {
                        $Type            : 'Common.ValueListParameterInOut',
                        LocalDataProperty: 'baseRule',
                        ValueListProperty: 'ID'
                    },
                    {
                        $Type            : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'description'
                    }
                ]
            })
            baseRule,
            modifiedAt,
            modifiedBy,
            createdAt,
            createdBy

        };

    function getApplicableRules(userId: String)      returns array of UserRules;

    action   checkForOverdueRules(userId: String)    returns String;

    

}
