using {RuleService} from './rule-service';

annotate RuleService.CodeUsers with @(restrict: [
    {
        grant: '*',
        to   : 'RuleAdmin'
    },

    {
        grant: 'READ',
        to   : [
            'authenticated-user',
            'RuleReader'
        ]
    }
]);

annotate RuleService.UserRules with @(restrict: [
    {
        grant: '*',
        to   : 'RuleAdmin'
    },
    {
        grant: 'WRITE',
        to   : ['RuleCreator']
    },

    {
        grant: 'READ',
        to   : [
            'authenticated-user',
            'RuleReader'
        ]
    }
]);

annotate RuleService.BaseRules with @(restrict: [{
    grant: 'READ',
    to   : [
        'RuleAdmin',
        'RuleCreator',
        'RuleReader',
        'authenticated-user'
    ]
}]);


annotate RuleService.checkForOverdueRules with @(requires: ['RuleAdmin']);

annotate RuleService.getApplicableRules with @(requires: [
    'RuleReader',
    'RuleAdmin',
    'RuleCreator'
]);
