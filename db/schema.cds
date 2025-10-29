namespace codeRules;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity BaseRule : cuid, managed {
    description : String(100);
    objectType  : String(10);
    ruleType    : String(20);
    value       : String(50);
}

entity UserRule : managed {
    key ID            : UUID;
        baseRule      : Association to one BaseRule;
        effectiveDate : Date;
        endDate       : Date;
        user          : Association to one CodeUser;
}

entity CodeUser : managed {
    key ID    : String(36);
        rules : Composition of many UserRule
                    on rules.user = $self;
}
