using {codeRules} from '../db/schema';

service RuleService @(path: '/codeRuleService') {
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


    entity UserRules as projection on codeRules.UserRule;

    function getApplicableRules(userId: String)      returns array of UserRules;

    action   checkForOverdueRules(userId: String)    returns String;

    action   fileUploadBaseRules(rules: LargeString) returns String;

}
