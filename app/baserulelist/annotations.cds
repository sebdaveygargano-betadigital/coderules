using RuleService as service from '../../srv/rule-service';
annotate service.BaseRules with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : 'description',
        },
        {
            $Type : 'UI.DataField',
            Value : objectType,
            Label : 'objectType',
        },
        {
            $Type : 'UI.DataField',
            Value : ruleType,
            Label : 'ruleType',
        },
        {
            $Type : 'UI.DataField',
            Value : value,
            Label : 'value',
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
        },
        {
            $Type : 'UI.DataField',
            Value : modifiedAt,
        },
    ],
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Administrative Info',
            ID : 'AdministrativeInfo',
            Target : '@UI.FieldGroup#AdministrativeInfo',
        },
    ],
    UI.FieldGroup #AdministrativeInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : createdBy,
            },
            {
                $Type : 'UI.DataField',
                Value : createdAt,
            },
            {
                $Type : 'UI.DataField',
                Value : modifiedAt,
            },
            {
                $Type : 'UI.DataField',
                Value : modifiedBy,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Code Rule Details',
            ID : 'CodeRuleDetails',
            Target : '@UI.FieldGroup#CodeRuleDetails',
        },
    ],
    UI.FieldGroup #CodeRuleDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : ID,
                Label : 'ID',
            },
            {
                $Type : 'UI.DataField',
                Value : description,
                Label : 'description',
            },
            {
                $Type : 'UI.DataField',
                Value : objectType,
                Label : 'objectType',
            },
            {
                $Type : 'UI.DataField',
                Value : ruleType,
                Label : 'ruleType',
            },
            {
                $Type : 'UI.DataField',
                Value : value,
                Label : 'value',
            },
        ],
    },
);

