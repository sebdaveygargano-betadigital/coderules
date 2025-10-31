using {BaseRuleService} from './baserule-service';


annotate BaseRuleService.BaseRules with @(restrict: [
    {
        grant: '*',
        to   : 'RuleAdmin'
    },
    {
        grant: [
            'CREATE',
            'UPDATE',
            'READ'
        ],
        to   : 'RuleCreator'
    },

    {
        grant: 'READ',
        to   : 'RuleReader'

    },
    {
        grant: 'READ',
        to   : 'authenticated-user'
    }
]);


// ---------------------------
// ACTION: fileUploadBaseRules
// ---------------------------

// Grant access to RuleAdmin and RuleCreator only
annotate BaseRuleService.fileUploadBaseRules with @(requires: [
    'RuleAdmin',
    'RuleCreator'
]);
