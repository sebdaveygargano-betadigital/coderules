using {BaseRuleService} from './baserule-service';

annotate BaseRuleService with @(restrict: [
                                           /*
                                           {
                                               grant: '*',
                                               to   : 'RuleAdmin'
                                           },*/

                                          {
    grant: '*',
    to   : 'authenticated-user'
}]);
