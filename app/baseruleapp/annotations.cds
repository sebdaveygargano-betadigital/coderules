using BaseRuleService as service from '../../srv/baserule-service';
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
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Rule Details',
            ID : 'RuleDetails',
            Target : '@UI.FieldGroup#RuleDetails',
        },
    ],
    UI.FieldGroup #RuleDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
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
    UI.HeaderInfo : {
        TypeName : 'Base Rule',
        TypeNamePlural : 'Base Rules',
        Title : {
            $Type : 'UI.DataField',
            Value : ID,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : 'Code Rule Template',
        },
    },
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Admin Info',
            ID : 'AdminInfo',
            Target : '@UI.FieldGroup#AdminInfo',
        },
    ],
    UI.FieldGroup #AdminInfo : {
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
);

