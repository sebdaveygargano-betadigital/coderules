sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"baserulelist/test/integration/pages/BaseRulesList",
	"baserulelist/test/integration/pages/BaseRulesObjectPage"
], function (JourneyRunner, BaseRulesList, BaseRulesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('baserulelist') + '/test/flp.html#app-preview',
        pages: {
			onTheBaseRulesList: BaseRulesList,
			onTheBaseRulesObjectPage: BaseRulesObjectPage
        },
        async: true
    });

    return runner;
});

