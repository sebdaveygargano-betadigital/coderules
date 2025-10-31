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
        grant: ['CREATE', 'READ'],
        to: 'RuleM2M'
    },

    {
        grant: 'READ',
        to   : [
            'RuleReader',
            'authenticated-user',
        ]

    }
]);


// ---------------------------
// ACTION: fileUploadBaseRules
// ---------------------------

// Grant access to RuleAdmin and RuleCreator only
annotate BaseRuleService.fileUploadBaseRules with @(requires: [
    'RuleAdmin',
    'RuleCreator',
    'RuleM2M'
]);
