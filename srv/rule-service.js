const cds = require('@sap/cds');

module.exports = (srv) => {
    // Get the entities from your service definition (the projections)
    const { UserRules, BaseRules, CodeUsers } = srv.entities;


    /**
     * Get all rules that are currently active for a user.
     * (Current date is between effectiveDate and endDate)
     *
     * This implementation returns a JSON string of the UserRules array
     * to match the "returns String" service definition.
     */
    srv.on('getApplicableRules', async (req) => {
        const { userId } = req.data;
        if (!userId) {
            return req.error(400, 'User ID is required');
        }

        // Use the new transaction signature cds.tx(req)
        const tx = cds.tx(req);
        // Get today's date in 'YYYY-MM-DD' format for comparison
        const today = new Date().toISOString().split('T')[0];

        // Use SELECT.from on the service projection 'UserRules'
        const activeRules = await tx.run(
            SELECT.from(UserRules, r => {
                r`.*`, // Select all fields from UserRule
                    r.baseRule(b => b`.*`) // Expand the baseRule association
            })
                .where({
                    user_ID: userId,       // Filter by the user (string ID)
                    and: {
                        effectiveDate: { '<=': today }, // and today is on or after the start date
                        endDate: { '>=': today }        // and today is on or before the end date
                    }
                })
        );

        // Return as a JSON string to match the service definition
        return activeRules;
    });

    /**
     * Checks for and removes all rules for a user that are no longer valid.
     * (Current date is NOT between effectiveDate and endDate)
     */
    srv.on('checkForOverdueRules', async (req) => {
        const { userId } = req.data;
        if (!userId) {
            return req.error(400, 'User ID is required');
        }
        const tx = cds.tx(req);
        const today = new Date().toISOString().split('T')[0];

        const overdueRules = await tx.run(
            SELECT.from(UserRules, ['ID'])
                .where({
                    user_ID: userId,       // Filter by the user (string ID)
                    and: {
                        effectiveDate: { '>': today }, // and today is on or after the start date
                        endDate: { '<': today }        // and today is on or before the end date
                    }
                })
        );

        if (overdueRules.length === 0) {
            return `No overdue rules found for user ${userId}.`;
        }

        // 2. Get the list of IDs and delete them
        const ruleIDs = overdueRules.map(rule => rule.ID);

        // Use the service projection 'UserRules'
        const deleteResult = await tx.run(
            DELETE.from(UserRules)
                .where({ ID: { in: ruleIDs } })
        );

        // deleteResult is the number of rows affected
        return `Removed ${deleteResult} overdue rules for user ${userId}.`;
    });



};