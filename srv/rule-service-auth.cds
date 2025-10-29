using {RuleService} from './rule-service';

annotate RuleService with @(restrict: [
                                       /*
                                       {
                                           grant: '*',
                                           to   : 'RuleAdmin'
                                       },
                                        {
                                            grant: 'READ',
                                            to   : 'RuleReader'
                                        }*/
                                      {
    grant: '*',
    to   : 'authenticated-user'
}]);
