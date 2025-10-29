sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"codeusersapp/test/integration/pages/CodeUsersList",
	"codeusersapp/test/integration/pages/CodeUsersObjectPage"
], function (JourneyRunner, CodeUsersList, CodeUsersObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('codeusersapp') + '/test/flp.html#app-preview',
        pages: {
			onTheCodeUsersList: CodeUsersList,
			onTheCodeUsersObjectPage: CodeUsersObjectPage
        },
        async: true
    });

    return runner;
});

