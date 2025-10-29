const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');

module.exports = (srv) => {
    const { BaseRules } = srv.entities;



    srv.before('CREATE', 'BaseRules', async (req) => {

        const { objectType, ruleType, value } = req.data;

        // Validate required fields (optional but recommended)
        if (!objectType || !ruleType || !value) {
            return req.error(400, 'objectType, ruleType and value are required fields.');
        }

        // Check uniqueness
        const result = await SELECT.one.from(BaseRules)
            .where({
                objectType,
                ruleType,
                value
            });

        if (result) {
            return req.error(
                409,
                `A rule already exists with the same objectType (${objectType}), ruleType (${ruleType}) and value (${value}). Existing ID: ${result.ID}`
            );
        }

        // Otherwise allow create
    });

    srv.on('fileUploadBaseRules', async (req) => {
        console.log("CP1");
        const { rules: rulesJsonString } = req.data;
        if (!rulesJsonString) return req.error(400, 'No rules payload found.');

        let rules;
        try { rules = JSON.parse(rulesJsonString) }
        catch (e) { return req.error(400, `Invalid JSON payload: ${e.message}`) }

        console.log("CP2");
        if (!Array.isArray(rules) || rules.length === 0)
            return req.error(400, 'Payload must be a non-empty array of rules.');

        const tx = cds.tx(req);

        try {
            console.log("CP3");
            //Normalize input and remove empty rows
            rules = rules
                .map(r => ({
                    description: r.description?.trim(),
                    objectType: r.objectType?.trim(),
                    ruleType: r.ruleType?.trim(),
                    value: r.value?.trim()
                }))
                .filter(r => r.objectType && r.ruleType && r.value);

            if (rules.length === 0)
                return req.error(400, 'All uploaded rows were empty or invalid.');

            // Detect duplicates inside upload itself (no self-collisions)
            const seen = new Set();
            for (const r of rules) {
                const key = `${r.objectType}::${r.ruleType}::${r.value}`;
                if (seen.has(key))
                    return req.error(409, `Duplicate detected within uploaded file: (${key})`);
                seen.add(key);
            }
            console.log("CP4");
            // Detect duplicates already existing in DB
            const existing = [];
            for (let i = 0; i < rules.length; i++) {
                const [entry] = await tx.run(SELECT.from(BaseRules)
                    .columns('objectType', 'ruleType', 'value')
                    .where({
                        objectType: rules[i].objectType,
                        ruleType: rules[i].ruleType,
                        value: rules[i].value
                    }))
                if (entry) { existing.push(entry) }
            }
            console.log("CP4.5");
            console.log("existing : ", existing);

            if (existing.length > 0) {
                const duplicates = existing
                    .map(r => `${r.objectType}::${r.ruleType}::${r.value}`)
                    .join(', ');
                return req.error(409, `The following rules already exist in the system: ${duplicates}`);
            }
            console.log("CP5");

            // Perform atomic multi-insert (rollback on ANY failure)
            await tx.run(
                INSERT.into(BaseRules).entries(rules)
            );
            console.log("CP6");
            return `Successfully uploaded ${rules.length} Base Rules.`;

        } catch (err) {
            return req.error(500, `Failed to upload rules: ${err.message}`);
        }
    });

}
