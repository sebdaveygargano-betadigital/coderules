using {BaseRuleService} from './baserule-service';

annotate BaseRuleService with @(restrict: [
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
        to : 'authenticated-user'
    }
]);
