using {codeRules} from '../db/schema';

service BaseRuleService @(path: '/baseRuleService') {
    @odata.draft.enabled
    entity BaseRules as projection on codeRules.BaseRule;

    action fileUploadBaseRules(rules: LargeString) returns String;

}
