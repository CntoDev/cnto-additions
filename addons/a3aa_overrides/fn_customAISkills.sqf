/*
 * configure AI / Dynamic skill custom static AI skill equivalent to
 * - default vanilla CfgAISkill
 * - precisionAI=0.5 / skillAI=1
 * - individual unit skill = 0.5 (default)
 *
 * pulled directly from the game via skillFinal
 */

a3aa_ai_dynamic_skill_custom = {
    [
        0.4625,  // aimingAccuracy
        0.4625,  // aimingShake
        0.875,   // aimingSpeed
        0.75,    // endurance
        0.75,    // spotDistance
        0.75,    // spotTime
        0.75,    // courage
        0.75,    // reloadSpeed
        0.75,    // commanding
        0.75     // general
    ];
};
